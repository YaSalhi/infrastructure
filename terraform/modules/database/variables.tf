variable "server_name" {}
variable "db_name" {}
variable "resource_group_name" {}
variable "location" {
      default = "northeurope"
}
variable "admin_login" {
  default = "azureadmin"
}
variable "admin_password" {}
variable "sku_name" {
  default = "S0"
}
