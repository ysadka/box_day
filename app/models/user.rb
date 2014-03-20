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

  def get_hashtag
    topic = "#ironbox"
    @client.filter(track: topic) do |object|
      if object.is_a?(Twitter::Tweet)
        puts object.to_h

        # Info to pull:
        # object.text
        # object.screen_name
        # object.media_url_https


        # Thread.new do
        #   # store
        #   # @iron_client.task_create(workername, {tweet, image_url})
        # end
      end
    end
  end
end
