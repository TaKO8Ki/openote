module SettingsHelper
  def already_integrated(user, provider)
    if user.social_profiles.present?
      user.social_profiles.find_by(provider: provider).present?
    end
  end

  def user_social_profile(user, provider)
    social_profile = user.social_profiles.find_by(provider: provider)
    return social_profile
  end
end
