get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  @user = TwitterUser.create(username: params[:username]) unless @user
  if @user.tweets.empty?
    @user.get_tweets
  end
  if @user.tweets_stale?
    @user.tweets.destroy_all
    @user.get_tweets
  end
  @tweets = @user.tweets.limit(10)
  erb :username
end

#!/usr/bin/env ruby
