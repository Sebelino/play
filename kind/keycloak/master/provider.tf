provider "keycloak" {
  client_id     = "tf-automation"
  client_secret = var.client_secret
  url           = "http://localhost:80"
}
