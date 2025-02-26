require 'nokogiri'
require 'pp'

puts "Warning: this script may generate false positive warnings when an endpoint name exists in multiple APIs."
puts "Always manually validate before updating the version number in a link."
puts ""

def extract_version(url)
  match = url.match(/\/(\d+\.\d+)\//)
  match ? match[1] : nil
end

def parse_api_list(file_path)
  api_list = {}
  current_api = nil
  current_versions = nil

  File.readlines(file_path).each do |line|
    if line.start_with?('API:')
      match = line.match(/API: \[(.+)\]\((.*)\)/)
      if match
        api_name = match[1]
        current_api = api_name
        api_list[current_api] = { endpoints: [] }
      end
    elsif line.start_with?('(Sandbox:') && current_api
      match = line.match(/\(Sandbox: (\d+\.\d+), Production: ((?:\d+\.\d+)|N\/A)\)/)
      if match
        sandbox_version = match[1]
        production_version = match[2]
        api_list[current_api][:sandbox] = sandbox_version
        api_list[current_api][:production] = production_version
      end
    elsif line.start_with?('- Endpoint:') && current_api
      endpoint_name = line.match(/- Endpoint: (.+)/)&.captures&.first
      api_list[current_api][:endpoints] << endpoint_name if endpoint_name
    end
  end

  api_list
end

def check_markdown_links(api_list, file_path)
  markdown = File.read(file_path)
  warnings = []
  url_stem = 'https://developer.service.hmrc.gov.uk'

  markdown.scan(/\[.*?\]\((.*?)\)/).each do |match|
    href = match[0]
    next unless href.start_with?(url_stem)

    link_version = extract_version(href)
    next if link_version.nil?

    api_name = href.split('/').find { |part| part.end_with?('-api') }&.gsub('-api', '')&.split('-')&.map(&:capitalize)&.join(' ')
    next if api_name.nil?

    api_info = api_list[api_name]
    next if api_info.nil?

    if api_info[:production] == 'N/A'
      warnings << [href, api_name, link_version, api_info[:sandbox], api_info[:production], 'no prod version']
    elsif link_version < api_info[:production]
      warnings << [href, api_name, link_version, api_info[:sandbox], api_info[:production], 'stale (newer prod version available)']
    elsif link_version == api_info[:sandbox] && link_version > api_info[:production]
      warnings << [href, api_name, link_version, api_info[:sandbox], api_info[:production], 'links to sandbox version when prod is lower']
    elsif link_version > api_info[:sandbox]
      warnings << [href, api_name, link_version, api_info[:sandbox], api_info[:production], 'links to version that is not public (broken?)']
    end
  end

  if warnings.any?
    puts "Warnings for file: #{file_path}"
    warnings.each do |warning|
      puts "----"
      puts "URL: #{warning[0]}"
      puts "API name: #{warning[1]}"
      puts "Markdown version: #{warning[2]}"
      puts "Sandbox version: #{warning[3]}"
      puts "Production version: #{warning[4]}"
      puts "Problem: #{warning[5]}"
    end
  else
    puts "No warnings for file: #{file_path}"
  end
end

# Get the file paths from command-line arguments
api_list_file = 'api-list.md'
markdown_directory = 'source/documentation'

# Parse the API list
api_list = parse_api_list(api_list_file)

# Check each Markdown file in the directory for mismatched version numbers in links
Dir.glob("#{markdown_directory}/**/*").each do |file_path|
  next if File.directory?(file_path) || File.extname(file_path) != '.md' || File.basename(file_path).start_with?('_')
  puts "------"
  puts "Checking file: #{file_path}"
  check_markdown_links(api_list, file_path)
end