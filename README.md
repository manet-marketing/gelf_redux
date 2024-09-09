## GELF (redux) Ruby library
This gem is intended to replace the existing and unmaintained gelf-rb https://github.com/graylog-labs/gelf-rb - since
the project went silent for a few years and there seems to be no intention in continuing any kind of support
(https://github.com/graylog-labs/gelf-rb/issues/93). So we decided to not just fork but set up a new gem.
Since we needed support for http(s) transports as well we are mirroring this fork (https://github.com/christianrolle/gelf-rb) instead
of the original project because we wanted to keep all of the projects and maintainers history.

## Versioning

- 3.1.1 is the latest original gelf-rb version ()
- 3.2.1 is the first http(s) supporting version from here https://github.com/christianrolle/gelf-rb
- 4.0.0 we do start from here with our versioning, improvements and updates



## Usage
### Gelf::Notifier

This allows you to send arbitary messages via UDP to Graylog.

    n = GELF::Notifier.new("localhost", 12201)

    # Send with custom attributes and an additional parameter "foo"
    n.notify!(:short_message => "foo", :full_message => "something here\n\nbacktrace?!", :_foo => "bar")

    # Pass any object that responds to .to_hash
    n.notify!(Exception.new)

The recommended default is to send via UDP but you can choose to send via TCP like this:

    n = GELF::Notifier.new("127.0.0.1", 12201, "LAN", { :protocol => GELF::Protocol::TCP })

Note that the `LAN` or `WAN` option is ignored for TCP because no chunking happens. (Read below for more information.)

### Gelf::Logger

The Gelf::Logger is compatible with the standard Ruby Logger interface and can be used interchangeably.
Under the hood it uses Gelf::Notifier to send log messages via UDP to Graylog.

    logger = GELF::Logger.new("localhost", 12201, "WAN", { :facility => "appname" })

    logger.debug "foobar"
    logger.info "foobar"
    logger.warn "foobar"
    logger.error "foobar"
    logger.fatal "foobar"

    logger << "foobar"

Then `WAN` or `LAN` option influences the UDP chunk size depending on if you send in your own
network (LAN) or on a longer route (i.e. through the internet) and should be set accordingly.

Since it's compatible with the Logger interface, you can also use it in your Rails application:

    # config/environments/production.rb
    config.logger = GELF::Logger.new("localhost", 12201, "WAN", { :facility => "appname" })

### Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Run the tests with `bundle exec rake` 
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Contributions
* Feel free to open up pull request

### Running the tests
* install docker with compose

```bash
# install gems
docker-compose run --rm app bundle install
```

```bash
# run tests
docker-compose up
```