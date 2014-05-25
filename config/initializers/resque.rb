
  ENV["REDISTOGO_URL"] = 'redis://redistogo:d0362e0f606724cd45cc16a0c1f8a218@angelfish.redistogo.com:10043/'

  
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)