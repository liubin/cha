module ApplicationHelper
  def user_link(user)
    content_tag(:a, :href => "/profile/#{user.id}") do
      concat(content_tag(:img, :class => 'avatar avatar-36', :src => user.profile.avatar.url(:thumb)) do
      end).concat user.profile.nick
    end
  end
end
