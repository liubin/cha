class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :lockable, :invitable

  before_save :set_admin

  has_one :profile

  def send_devise_notification(notification, *args)
    if Rails.env.development?
      devise_mailer.send(notification, self, *args).deliver_now
    else
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end

  private
    def set_admin
      if self.new_record?
        self.admin = (User.count == 0)
      end
      true
    end
end
