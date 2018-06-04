module ApplicationHelper
  #Gravatar_for method, including the size of the picture
  def gravatar_for(user, options = { size: 80 })
    #Gravatar image is MD5
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "img-circle")
  end
end
