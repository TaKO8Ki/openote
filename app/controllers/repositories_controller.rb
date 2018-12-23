class RepositoriesController < ApplicationController
  def index
    if current_user.social_profiles.where(provider: "github").present?
      manage_repository(current_user)
      @repositories = Repository.where(user_id: current_user.id).order("created_at DESC")
    else
      @non_repositories =  "Githubとの連携をして、レポジトリを公開しましょう"
    end
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

  def manage_repository(user)
    repo_ids = github_repository(user).map(&:id)
    repo_should_be_deleted = Repository.where.not(repo_id: repo_ids)

    github_repository(user).each do |repo|
      repository = Repository.find_by(repo_id: repo.id)
      if repository.nil?
        Repository.create(name: repo.name, user_id: user.id, repo_id: repo.id)
      end
    end
    if repo_should_be_deleted.present?
      repo_should_be_deleted.destroy_all
    end
  end

end
