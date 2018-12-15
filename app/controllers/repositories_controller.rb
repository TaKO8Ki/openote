class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.where(user_id: current_user.id).order("created_at DESC")
  end

  def update
    @repository = Repository.find(params[:id])
    @repository.update(status: params[:status])
  end

  private

  def github_repository(user)
    user_token = access_token_of_each_of_providers(user, "github")
    github = Github.new oauth_token: "#{user_token}"
    user_repos = github.repos.list
  end

  def access_token_of_each_of_providers(user, provider)
    access_token = user.social_profiles.find_by(provider: provider).access_token
  end

  def manage_repository
    repo_ids = github_repository(current_user).map(&:id)
    repo_should_be_deleted = Repisitory.where.not(id: repo_ids)

    github_repository(current_user).each do |repo|
      repository = Repository.find_by(repo_id: repo.id).present?
      if repo.nil?
        Repository.create(user_id: current_user, repo_id: repo.id)
      end
    end
    if repo_should_be_deleted.present?
      repo_should_be_deleted.destroy_all
    end
  end

end
