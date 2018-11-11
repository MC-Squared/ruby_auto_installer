# RubyAutoInstaller

RubyAutoInstaller is designed to be run automatically (cronjob, startup, etc) and install Ruby versions.
This saves the downtime of waiting for new Ruby versions to download an compile.

## Installation

    $ gem install ruby_auto_installer

## Usage

```
Usage:
  ruby_auto_installer update

Options:
  -n, [--manager-name=MANAGER_NAME]  # Manager to use (asdf/rbenv/rvm)
  -v, [--verbose]                    # Verbose output
  -g, [--greedy]                     # Install all versions, not just latest patch
  -m, [--min-version=MIN_VERSION]    # Minimum Ruby version to consider (i.e."2.0")
  -d, [--dry_run]                    # List versions that would be installed, but do not install 
```

By default only the latest patch version will be installed

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mc-squared/ruby_auto_installer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
