
# ressource groupe
module "rg_dev" {
  source   = "./modules/resource_group"
  rg_name  = "rg-dev-env"
  location = "West Europe"
}


# App Service Plan
module "plan_dev" {
  source              = "./modules/app_service_plan"
  name                = "plan-dev-env"
  resource_group_name = module.rg_dev.rg_name
  location            = module.rg_dev.location
}

# Web App Service
module "webapp_dev" {
  source              = "./modules/web_app"
  name                = "webapp-dev-env"
  resource_group_name = module.rg_dev.rg_name
  location            = module.rg_dev.location
  service_plan_id     = module.plan_dev.plan_id
}

# database
module "db_dev" {
  source              = "./modules/database"
  server_name         = "server-dev-env"
  db_name             = "db-dev-env"
  resource_group_name = module.rg_dev.rg_name
  location            = "northeurope"   # variable sql_location
  admin_password      = "Password123!" # ou via Key Vault
}