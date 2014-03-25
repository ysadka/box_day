namespace :twitter do

  desc "Listen and send to worker"

  def twitter
    if provider == 'twitter'
      config = {
        consumer_key: ENV['TWITTER_KEY'],
        consumer_secret: ENV['TWITTER_SECRET'],
        access_token: current_user.oauth_token,
        access_token_secret: current_user.oauth_secret
      }

      @client ||= Twitter::Streaming::Client.new(config)
    end
  end

  def push_to_worker(worker, object)
    client = IronWorkerNG::Client.new(token: ENV['IRON_TOKEN'], project_id: ENV['IRON_PROJECT_ID'])
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
    topic = ENV['TWITTER_TOPIC']
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
