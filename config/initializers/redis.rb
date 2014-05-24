
uri = URI.parse(ENV["redis://redistogo:d0362e0f606724cd45cc16a0c1f8a218@angelfish.redistogo.com:10043/"])
REDIS = Redis.new(:url => ENV['redis://redistogo:d0362e0f606724cd45cc16a0c1f8a218@angelfish.redistogo.com:10043/'])