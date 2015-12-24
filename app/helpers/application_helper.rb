module ApplicationHelper
  def user_link(user)
    if user.profile.nil?
      img = Profile::DEFAULT_AVATAR_URL.sub(':style', 'thumb')
      nick = '未完成注册'
    else
      img = user.profile.avatar.url(:thumb)
      nick = user.profile.nick
    end
    content_tag(:a, :href => "/profile/#{user.id}") do
      concat(content_tag(:img, :class => 'avatar avatar-36', :src => img) do
      end).concat nick
    end
  end
end
