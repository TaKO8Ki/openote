module UsersHelper

  def resource_name
    :user
  end

  def resource_class
    devise_mapping.to
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def following_tags(user)
     if user.user_tags.present?
      following_tags_ids = UserTag.where(user_id: user).pluck(:tag_id)
      following_tags = ActsAsTaggableOn::Tag.where(id: following_tags_ids)
    end
    return following_tags
  end

end
