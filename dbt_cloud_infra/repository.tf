resource "dbtcloud_repository" "ambergrid_repository" {
  project_id             = dbtcloud_project.ambergrid_project.id
  remote_url             = var.github_remote_url
  github_installation_id = var.github_installation_id
  git_clone_strategy     = "github_app"
}

resource "dbtcloud_project_repository" "ambergrid_project_repository" {
  project_id    = dbtcloud_project.ambergrid_project.id
  repository_id = dbtcloud_repository.ambergrid_repository.repository_id
}
