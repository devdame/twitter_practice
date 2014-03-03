get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  @user = TwitterUser.create(username: params[:username]) unless @user
  if @user.tweets.empty? || @user.tweets_stale?
    erb :loading
  else
    @tweets = @user.tweets.limit(10)
    erb :username
  end
end

post '/refresh_tweets' do
  @user = TwitterUser.find_by_username(params[:username])
  if @user.tweets.empty?
    @user.get_tweets
  else @user.tweets_stale?
    @user.tweets.destroy_all
    @user.get_tweets
  end
  @tweets = @user.tweets.limit(10)
  erb :_tweet_list
end

