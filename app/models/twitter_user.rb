class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def get_tweets
    $client.user_timeline(username).each do |tweet|
      Tweet.create(twitter_user_id: id, text: tweet.text, created_at: tweet.created_at)
    end
  end

  def tweets_stale?
    Time.now.utc - self.tweets.first.updated_at > 900
  end

end
