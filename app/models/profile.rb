class Profile < ActiveRecord::Base
  belongs_to :user
  # avatar
  has_attached_file :avatar, styles: { medium: '200x200#', thumb: '50x50#' }, default_url: "/images/avatar/:style/default.png",
    url: "/avatar/:hash.:extension", hash_secret: "hehe"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
