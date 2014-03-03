class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def get_tweets
    $client.user_timeline(username).each do |tweet|
      Tweet.create(twitter_user_id: id, text: tweet.text, created_at: tweet.created_at)
    end
  end

  def tweets_stale?
    Time.now.utc - self.tweets.first.updated_at > average_tweet_time
  end

  def average_tweet_time
    tweet_diffs = 0
    all_tweets = self.tweets
    all_tweets.each_with_index do |tweet, index|
      unless index == all_tweets.length - 1
        tweet_diffs += (tweet.created_at - all_tweets[index + 1].created_at).abs
      end
    end
    tweet_diffs/all_tweets.length
  end

end
