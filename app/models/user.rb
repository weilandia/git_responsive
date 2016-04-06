class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    where(uid: auth[:uid], provider: auth[:provider]).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.nickname = auth.info.nickname
      user.token = auth.credentials.token
    end
  end
end
