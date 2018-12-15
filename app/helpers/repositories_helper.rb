module RepositoriesHelper

  def public_repo?(repo)
    if Repository.find_by(repo_id: repo.id).present?
      Repository.find_by(repo_id: repo.id).status == "public"
    else
      true
    end
  end
end
