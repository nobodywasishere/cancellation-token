module Cancel
  # A cancellation source creates and controls a `CancellationToken`.
  class TokenSource
    @channel : Channel(Nil)

    getter token : Token

    def initialize
      @channel = Channel(Nil).new
      @token = Token.new(@channel)
    end

    # Cancels the associated token, non-blocking
    def cancel : Nil
      @channel.close
    end
  end

  # A cancellation token is passed to an asynchronous or long running operation to request cancellation,
  # like cancelling a request for completion items because the user continued to type.
  #
  # To get an instance of a `CancellationToken` use a `CancellationTokenSource`.
  class Token
    # :nodoc:
    def initialize(@channel : Channel(Nil))
    end

    # Checks if the token is cancelled, non-blocking
    def cancelled? : Bool
      @channel.closed?
    end

    def cancelled! : Nil
      raise CancelledException.new
    end
  end

  class CancelledException < Exception
  end
end
