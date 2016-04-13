# messenger-bot-ruby

Ruby wrapper for [Messenger's Platform Bot API](https://developers.facebook.com/docs/messenger-platform).

[![Gem Version](https://badge.fury.io/rb/messenger-bot-ruby.svg)](http://badge.fury.io/rb/messenger-bot-ruby)

This library is heavily based on the great [telegram-bot-ruby](https://github.com/atipugin/telegram-bot-ruby) gem written by [Alexander Tipugin](mailto:atipugin@gmail.com) and its main goal is let you easily integrate your (existing?) Telegram Bot with Messenger.

## Prerequisites

Messenger platform uses the webhook pattern to send you updates on events, requiring a TLS encrypted connection.

### Development: ngrok

To be able to use the bot on your development machine I heavily suggest you to purchase a [ngrok Pro subscription](https://ngrok.com/product#pricing) (billed monthly or yearly). I struggled with [localtunnel](https://localtunnel.me) that's free, but at the moment has a bug (it crashes losing the tunnel and the domain) and you have to reconfigure the webhook on Facebook every few minutes.

Remember to [authorize your machine](https://dashboard.ngrok.com/auth) after you purchase the subscription.

Whenever you need to develop, start a tunnel following the ngrok instructions, but something like this should suffice:

```shell
ngrok http 9292
```

where `http` is the protocol (if authenticated will establish also the encrypted `https` tunnel), `9292` is the default Cuba port.

```shell
Forwarding                    http://bf6ab2c6.ngrok.io -> localhost:9292
Forwarding                    https://bf6ab2c6.ngrok.io -> localhost:9292
```

The interesting information is the `https://bf6bb3c6.ngrok.io` forwarded address, you need to use it on Facebook to configure the webhook appending the `/messenger` path.

So your webhook should point to something like

    https://bf6ab2c6.ngrok.io/messenger

Please follow the [official guide](https://developers.facebook.com/docs/messenger-platform) and once completed you can proceed.

### Production: Let's Encrypt

On the production machine I cannot praise enough [Let's Encrypt](http://letsencrypt.org): free and secure TLS certificates for everyone (I'm using it on many production projects and it rocks!).

## Quick start

Clone this repository and start a terminal session inside the folder and execute the following commands to fetch the necessary dependancies and start the server.

```shell
bundle
bundle exec rackup
```

The `rackup` command will start a Cuba server using the sample file in `examples/bot.rb`.
There you should replace the `YOUR_MESSENGER_PAGE_TOKEN_HERE` string with the page token provided by Facebook (follow the [official guide](https://developers.facebook.com/docs/messenger-platform) to know more).

## Installation

Add following line to your Gemfile:

```ruby
gem 'messenger-bot-ruby'
```

And then execute:

```shell
$ bundle
```

Or install it system-wide:

```shell
$ gem install messenger-bot-ruby
```

## Usage

Take a look at the `examples/bot.rb` file reported below.
I'm planning to add detailed informations in the next few days.

```ruby
require 'bundler/setup'
require 'cuba'
require 'multi_json'
require 'messenger/bot'

token = "YOUR_MESSENGER_PAGE_TOKEN_HERE"
bot = Messenger::Bot::Client.new(token)

# deserialize JSON data from request body
def json_load(request_body)
  request_body.rewind
  body = request_body.read
  MultiJson.load body
end

Cuba.define do
  on get do
    on "messenger" do
      on param("hub.mode"), param("hub.challenge"), param("hub.verify_token") do |mode, challenge, token|
        if mode == "subscribe"
          # TODO: check the verify_token value that you inserted on the facebook developer page
          res.write challenge
        end
      end
    end
    on root do
      res.write "Hello world!"
    end
  end

  on post do
    puts "Got a post call #{res.to_json}"
    on "messenger" do
      data = json_load req.body
      # puts "#{data}"
      res.write "" #200
      callback = Messenger::Bot::Types::Callback.new(data)
      for e in callback.entry
        for mess in e.messaging
          if mess.message
            if mess.sender.id # We have someone to send the message to!
              options = {bot: bot, messaging: mess, token: token}
              bot.api.messages(recipient: {id: mess.sender.id}, message: { text: "Hello from a Bot!"})
            end
          else
            puts "Received Postback or delivery"
          end
        end
      end
    end
  end
end

```

## Aknowledgments

Idea and initial implementation by [Matteo Gavagnin](https://twitter.com/macteo)
Thanks again to [Alexander Tipugin](mailto:atipugin@gmail.com) for inspiration and the [original gem](https://github.com/atipugin/telegram-bot-ruby) architecture.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under MIT license.
