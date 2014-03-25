class User < ActiveRecord::Base

  validates :provider,     presence: true
  validates :uid,          presence: true
  validates :username,     presence: true
  validates :oauth_secret, presence: true
  validates :oauth_token,  presence: true

  def self.from_omniauth(auth)
    user = where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
    user.oauth_token = auth['credentials']['token']
    user.oauth_secret = auth['credentials']['secret']
    user.save!
    user
  end

  def self.create_from_omniauth(auth)
    User.new( provider: auth['provider'],
              uid: auth['uid'],
              username: auth['info']['nickname']
            )
  end

  def twitter
    if provider == 'twitter'
      config = {
        consumer_key: ENV['TWITTER_KEY'],
        consumer_secret: ENV['TWITTER_SECRET'],
        access_token: oauth_token,
        access_token_secret: oauth_secret
      }

      @client ||= Twitter::Streaming::Client.new(config)
    end
  end

  def push_to_worker(worker, object)
    client = IronWorkerNG::Client.new
    client.tasks.create(worker, {
                                  object: object,
                                  keys:
                                    {
                                      consumer_key: ENV['TWITTER_KEY'],
                                      consumer_secret: ENV['TWITTER_SECRET'],
                                      access_token: oauth_token,
                                      access_token_secret: oauth_secret
                                    }
                                },
                        priority: 2
                        )
  end

  def get_hashtag
    topic = "#ironboxdemo"
    twitter.filter(track: topic) do |obj|
      if obj.is_a?(Twitter::Tweet)
        Thread.new do
          tweet = Tweet.create(
              body: obj.text,
              username: obj.user.screen_name,
              attached_photo: obj.to_h[:entities][:media][0][:media_url_https]
          )
            ActiveRecord::Base.connection.close
          push_to_worker('irontweet', obj)
          tweet.update_attribute(replied, true)
          tweet.save
        end
      end
    end
  end
end
