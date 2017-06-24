module ApplicationHelper

  def user_avatar(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    
    if user.profile_image.present?
    url = user.profile_image.image.url
    else
    image_url = user.image || "https://eliaslealblog.files.wordpress.com/2014/03/user-200.png"
    url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=150&d=#{CGI::escape(image_url)}"
    end

  end

  def number_to_currency_rm(number)
    number_to_currency(number, :unit => "RM")
  end


end
