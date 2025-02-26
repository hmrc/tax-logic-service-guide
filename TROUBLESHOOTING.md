# Troubleshooting OSX Install Issues

Many of the dependencies in this project are currently outdated.
There are multiple potential issues which could crop up when attempting to install the dependencies and run the app locally whilst using a Mac.
Some of these are described below:

## Installing Ruby

The current Ruby version in `.ruby-version` is `2.6.3`. This is no longer supported, so it's best to use a newer version of Ruby such as `3.2.0`.

## Bundle Install

You may need to remove the `Gemfile.lock` to get things running locally before running `bundle install`. You may also encounter the following issues:

### An error occurred while installing eventmachine (1.2.7)

You will need to install eventmachine separately, using a cppflag to point to your install of OpenSSL. This assumes you have 
OpenSSL installed through Brew. See this [Stack Overflow ticket](https://stackoverflow.com/questions/30818391/gem-eventmachine-fatal-error-openssl-ssl-h-file-not-found) for more info.

```
gem install eventmachine -v '1.2.7' -- --with-cppflags=-I$(brew --prefix openssl)/include
```

### An error occurred while installing thin (1.7.2)

You will need to install thin separately, using a cflag. See this [Stack Overflow ticket](https://stackoverflow.com/questions/63278694/thin-and-puma-fail-with-similar-issues-error-failed-to-build-gem-native-exten).

```
gem install thin -v '1.7.2' -- --with-cflags="-Wno-error=implicit-function-declaration"
```

### undefined method `untaint'

If you have not modified the existing `Gemfile.lock` you may see this error due to the `BUNDLED WITH` section, which forces the install
to use an older version of the Bundler which isn't compatible with the newer Ruby version. Try removing the `Gemfile.lock` before installing,
but remember not to commit this change.
