# Webhookr::Mandrill
[![Build Status](https://travis-ci.org/gerrypower/webhookr-mandrill.png?branch=master)](https://travis-ci.org/gerrypower/webhookr-mandrill)
[![Dependency Status](https://gemnasium.com/gerrypower/webhookr-mandrill.png)](https://gemnasium.com/gerrypower/webhookr-mandrill)
[![Code Climate](https://codeclimate.com/github/gerrypower/webhookr-mandrill.png)](https://codeclimate.com/github/gerrypower/webhookr-mandrill)
[![Coverage Status](https://coveralls.io/repos/gerrypower/webhookr-mandrill/badge.png?branch=master)](https://coveralls.io/r/gerrypower/webhookr-mandrill?branch=master)

This gem is a plugin for [Webhookr](https://github.com/zoocasa/webhookr) that enables
your application to accept [webhooks from Mandrill](http://help.mandrill.com/entries/21738186-Introduction-to-Webhooks).

## Installation

Add this line to your application's Gemfile:

    gem 'webhookr-mandrill'

Or install it yourself:

    $ gem install webhookr-mandrill

[webhookr](https://github.com/zoocasa/webhookr) is installed as a dependency of webhookr-mandrill. If you have not [setup Webhookr](https://github.com/zoocasa/webhookr#usage--setup), do so now:

```console
rails g webhookr:add_route
```

## Usage

Once you have the gem installed run the generator to add the code to your initializer.
An initializer will be created if you do not have one.

```console
rails g webhookr:mandrill:init *initializer_name* -s
```

Run the generator to create an example file to handle mandrill webhooks.

```console
rails g webhookr:mandrill:example_hooks
```

Or create a mandrill handler class for any event that you want to handle. For example
to handle unsubscribes you would create a class as follows:

```ruby
class mandrillHooks
  def on_spam(incoming)
    # Your custom logic goes here.
    User.unsubscribe_newletter(incoming.payload.msg.email)
  end
end
```

For a complete list of events, and the payload format, see below.

Edit config/initializers/*initializer_name* and change the commented line to point to
your custom Mandrill event handling class. If your class was called *MandrillHooks*
the configuration line would look like this:

```ruby
  Webhookr::Mandrill::Adapter.config.callback = MandrillHooks
```

To see the list of Mandrill URLs your application can use when you configure
mandrill webhooks,
run the provided webhookr rake task:

```console
rake webhookr:services
```

Example output:

```console
mandrill:
  GET	/webhookr/events/mandrill/19xl64emxvn
  POST	/webhookr/events/mandrill/19xl64emxvn
```

## Mandrill Events & Payload

### Events

All webhook events are supported. For further information on these events, see the
[mandrill documentation](http://help.mandrill.com/entries/21738186-Introduction-to-Webhooks).

<table>
  <tr>
    <th>Mandrill Event</th>
    <th>Event Handler</th>
  </tr>
  <tr>
    <td>send</td>
    <td>on_send(incoming)</td>
  </tr>
  <tr>
    <td>hard_bounce</td>
    <td>on_hard_bounce(incoming)</td>
  </tr>
  <tr>
    <td>soft_bounce</td>
    <td>on_soft_bounce(incoming)</td>
  </tr>
  <tr>
    <td>open</td>
    <td>on_open(incoming)</td>
  </tr>
  <tr>
    <td>click</td>
    <td>on_click(incoming)</td>
  </tr>
  <tr>
    <td>spam</td>
    <td>on_spam(incoming)</td>
  </tr>
  <tr>
    <td>unsub</td>
    <td>on_unsub(incoming)</td>
  </tr>
  <tr>
    <td>reject</td>
    <td>on_reject(incoming)</td>
  </tr>
</table>

### Payload

The payload is the full payload data from as per the
[mandrill documentation](http://help.mandrill.com/entries/24466132-Webhook-Format), converted to an OpenStruct
for ease of access. Examples for the method call unsubscribe:

```ruby
  incoming.payload.msg._id
  incoming.payload.msg.ts
  incoming.payload.msg.email
  incoming.payload.msg.sender
  incoming.payload.msg.subject
  incoming.payload.msg.opens
  incoming.payload.msg.tags
  incoming.payload.msg.state
  incoming.payload.msg.diag
  incoming.payload.msg.bounce_description
  incoming.payload.msg.template

```

### <a name="supported_services"></a>Supported Service - mandrill

* [http://help.mandrill.com/entries/21738186-Introduction-to-Webhooks](mandrill - v1.0)

## <a name="works_with"></a>Works with:

webhookr-mandrill works with Rails 3.1, 3.2 and 4.0, and has been tested on the following Ruby
implementations:

* 1.9.3
* 2.0.0
* jruby-19mode

### Versioning
This library aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/). Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, that
version should be immediately yanked and/or a new version should be immediately released that restores
compatibility. Breaking changes to the public API will only be introduced with new major versions. As a
result of this policy, once this gem reaches a 1.0 release, you can (and should) specify a dependency on
this gem using the [Pessimistic Version Constraint](http://docs.rubygems.org/read/chapter/16#page74) with
two digits of precision. For example:

    spec.add_dependency 'webhookr-mandrill', '~> 1.0'

While this gem is currently a 0.x release, suggestion is to require the exact version that works for your code:

    spec.add_dependency 'webhookr-mandrill', '0.0.1'

## License

webhookr-mandrill is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## Author

* [Gerry Power](https://github.com/gerrypower)
