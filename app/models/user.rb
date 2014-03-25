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
end
