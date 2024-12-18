require "./spec_helper"

describe CancellationToken do
  it "works" do
    token_source = CancellationTokenSource.new
    token = token_source.token

    token.cancelled?.should be_false
    token_source.cancel
    token.cancelled?.should be_true
  end

  it "works pt. 2" do
    token_source = CancellationTokenSource.new
    token = token_source.token
    counter = 0

    spawn do
      loop do
        break if token.cancelled?

        sleep(0.2.seconds)
        counter += 1
      end
    end

    sleep(0.7.seconds)
    token_source.cancel
    counter.should eq(3)
  end

  it "works pt. 3" do
    token_source = CancellationTokenSource.new
    token = token_source.token
    counter = 0

    spawn do
      loop do
        break if token.cancelled? && counter > 10

        counter += 1
      end
    end

    token_source.cancel
    sleep(1.second)
    counter.should eq(11)
  end
end
