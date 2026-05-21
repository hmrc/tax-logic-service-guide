# Technical Documentation - Tax Logic Service Guide

## Getting started

To preview or build the website, you need to use the terminal.

Install Ruby with Rubygems, preferably with a [Ruby version manager][rvm],
and the [Bundler gem][bundler].

In the application folder type the following to install the required gems (you may encounter errors, see the [Troubleshooting Guide](./TROUBLESHOOTING.md)):

```
bundle install
```
### Installation guidance by operating system

macOS: do not use the built-in Ruby that comes with macOS. It is best to install
a separate Ruby and rvm using [Homebrew](https://brew.sh/).

Windows: the best approach on Windows is to use
[RubyInstaller](https://rubyinstaller.org/). The guide is known to build
correctly on Windows 10 using RubyInstaller 3.2.2.

## Making changes

To make changes edit the source files in the `source` folder.

### Single page output

Although a single page of HTML is generated, the markdown is spread across
multiple files to make it easier to manage. They can be found in
`source/documentation`.

A new markdown file isn't automatically included in the generated output. If we
add a new markdown file at the location `source/documentation/agile/scrum.md`,
the following snippet in `source/index.html.md.erb`, includes it in the
generated output.

```
<%= partial 'documentation/agile/scrum' %>
```

Including files manually like this lets you specify the position they appear in
the page.

The `weight` variable specified at the beginning of each markdown file can be
used to specify the order of sections - a higher `weight` value is displayed
lower on the output page.

### Multiple pages

To add a completely new page, create a file with a `.html.md` extension in the `/source` directory.

For example, `source/about.html.md` will be accessible on <http://localhost:4567/about.html>.

## Preview

While writing documentation, you have two options for previewing how the published version will look in the browser:

1. Middleman Server: A live preview that shows changes instantly in the browser as changes are saved.
2. Play Framework Server: A preview that requires rebuilding the static files for each change but gives a more accurate
   representation of the service guide as it is used in higher environments (such as production).

It is important to preview changes locally before committing them.
The preview is only available on the local machine, and others won’t be able to access it if they are given the link.

### Option 1: Using the Middleman Server

This option provides a live preview of the static files.
Whenever a change is saved, the preview will automatically update in the browser, reflecting edits instantly.

To start the Middleman Server, run:

```bash
./preview_service_guide.sh middleman
```

Once the Middleman server is running, the live preview can be viewed at http://localhost:4567.

With this option, the preview is updated immediately whenever changes are made to the documentation,
making it ideal for quick iterations.

### Option 2: Using the Play Framework Server

This option provides a preview of the documentation that mirrors how it will be used in higher environments (such as production).
However, any changes made to the documentation will require rebuilding the static files before they appear in the preview.

To start the Play Framework Server, run:

```bash
./preview_service_guide.sh play
```
Once the Play server is running, the service guide can be viewed at http://localhost:9000/guides/tax-logic-service-guide/.

This option provides a preview more reflective of the deployed service guide, but it does not offer live previewing.
Rebuilding static HTML files is necessary each time changes are made.

**Note:** If no argument is provided when running the script, it will automatically use the Play Framework server. To specify an option,
simply use `middleman` or `play` as an argument when running the script.

### License

This code is open source software licensed under the [Apache 2.0 License]("http://www.apache.org/licenses/LICENSE-2.0.html").
