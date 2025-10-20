variable "name" {
  description = "Nom de l'App Service"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nom du Resource Group où sera déployé l'App Service"
  type        = string
}
 
variable "service_plan_id" {}
variable "node_version" {
  default = "18-lts"
}
variable "always_on" {
  default = false
}
