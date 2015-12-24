class Profile < ActiveRecord::Base
  DEFAULT_AVATAR_URL = "/images/avatar/:style/default.png"
  belongs_to :user
  # avatar
  has_attached_file :avatar, styles: { medium: '240x240#', thumb: '50x50#' }, default_url: Profile::DEFAULT_AVATAR_URL,
    url: "/avatar/:hash.:extension", hash_secret: "hehe"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
