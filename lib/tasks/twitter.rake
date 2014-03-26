namespace :test do

  desc "Listen and send to worker"

  task :stream => :environment do
    @current_user = User.find_by(username: 'getiron')
    @iron_client = IronWorkerNG::Client.new(token: ENV['IRON_TOKEN'], project_id: ENV['IRON_PROJECT_ID'])
    @config = {
      consumer_key: ENV['TWITTER_KEY'],
      consumer_secret: ENV['TWITTER_SECRET'],
      access_token: @current_user.oauth_token,
      access_token_secret: @current_user.oauth_secret
    }
    @stream ||= Twitter::Streaming::Client.new(@config)
    @client ||= Twitter::REST::Client.new(@config)

    topic = ENV['TWITTER_TOPIC']
    @stream.filter(track: topic) do |obj|
      if obj.is_a?(Twitter::Tweet) && obj.to_h[:entities][:media]
        Thread.new do
          begin
            mention = obj.text.include? "@getiron"
            tweet = Tweet.create(
                body: obj.text,
                iron_mention: mention,
                username: obj.user.screen_name,
                attached_photo: obj.to_h[:entities][:media][0][:media_url_https]
            )
            p 'Tweet Created'

            task_id = @iron_client.tasks.create( 'irontweet',
                                                  {
                                                    object: obj,
                                                    keys: @config
                                                  },
                                                  priority: 2
                                                )
            p "pushed @#{tweet.username} tweet to worker :)"

            tweet.update_attribute(:replied, true)
            tweet.save
            p "Replied to @#{tweet.username}"
            ActiveRecord::Base.connection.close

          rescue Exception => e
            p e
          end
        end
      elsif obj.is_a?(Twitter::Tweet) && obj.text.include?("#ironboxdemo")
        @client.update("@#{obj.user.screen_name} looks like you forgot to attach a photo")
      elsif obj == Twitter::Streaming::StallWarning || obj.is_a?(Twitter::Streaming::StallWarning)
        p "*"*20 + "Falling behind!" + "*"*20
      end
    end
  end
end
