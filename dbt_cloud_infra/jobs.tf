resource "dbtcloud_job" "production_job" {
  environment_id = dbtcloud_environment.production_environment.environment_id
  execute_steps = [
    "dbt build"
  ]
  generate_docs        = true
  is_active            = true
  name                 = "Production build job"
  num_threads          = var.dbt_threads
  project_id           = dbtcloud_project.ambergrid_project.id
  run_generate_sources = false
  target_name          = "prod"
  triggers = {
    "github_webhook" : false
    "git_provider_webhook" : false
    "schedule" : true
    "on_merge" : false
  }
  schedule_type = "custom_cron"
  schedule_cron = "0 3 * * *"

  execution = {
    timeout_seconds = 1800
  }
}

resource "dbtcloud_job" "slim_ci" {
  environment_id = dbtcloud_environment.slim_ci_environment.environment_id
  execute_steps = [
    "dbt build -s state:modified+ --fail-fast"
  ]
  generate_docs            = false
  deferring_environment_id = dbtcloud_environment.production_environment.environment_id
  name                     = "Slim CI"
  num_threads              = var.dbt_threads
  project_id               = dbtcloud_project.ambergrid_project.id
  run_generate_sources     = false
  target_name              = "ci"
  triggers = {
    "github_webhook" : true
    "git_provider_webhook" : true
    "schedule" : false
    "on_merge" : false
  }

  execution = {
    timeout_seconds = 3600
  }
}
