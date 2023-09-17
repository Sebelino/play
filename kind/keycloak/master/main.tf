resource "keycloak_realm" "this" {
  realm                       = "rebelino"
  default_signature_algorithm = "RS256"
  enabled                     = true
}
