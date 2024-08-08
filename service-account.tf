resource "google_service_account" "gemini_sa" {
  project      = module.project.project_id
  account_id   = "gemini-sa"
  display_name = "Service Account with Gemini Access"
}

# note this requires the terraform to be run regularly
resource "time_rotating" "sa_key_rotation" {
  rotation_days = 30
}

resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.gemini_sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"

  keepers = {
    rotation_time = time_rotating.sa_key_rotation.rotation_rfc3339
  }
}

resource "google_project_iam_custom_role" "gemini_access_role" {
  project     = module.project.project_id
  role_id     = "gemini_access_role"
  title       = "Gemini access only"
  description = "Role that allows access to gemini only"
  permissions = ["aiplatform.endpoints.predict"]
}

resource "google_project_iam_member" "gemini_sa_aiplatform_user" {
  project = module.project.project_id
  role    = google_project_iam_custom_role.gemini_access_role.id
  member  = "serviceAccount:${google_service_account.gemini_sa.email}"
}

resource "local_file" "sa_key_file" {
  content  = base64decode(google_service_account_key.sa_key.private_key)
  filename = "gemini-sa-key.json"
}
