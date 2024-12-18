# CancellationToken

Simple cancellation token using channels, based on the VS Code [CancellationToken](https://code.visualstudio.com/api/references/vscode-api#CancellationToken).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     cancellation_token:
       github: nobodywasishere/cancellation_token
   ```

2. Run `shards install`

## Usage

```crystal
require "cancellation_token"

# Create a new token source
token_source = CancellationTokenSource.new
token = token_source.token

# Spawn a fiber that checks the token to see if it should stop
spawn do
  loop do
    # Check to see if the fiber should stop
    if token.cancelled?
      break
    end

    puts "hello world"

    sleep(1.second)

    # Do fiber work here
  end
end

# Later on, if desired, cancel the token
token_source.cancel

```

## Contributing

1. Fork it (<https://github.com/nobodywasishere/cancellation_token/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Margret Riegert](https://github.com/nobodywasishere) - creator and maintainer
