
module "rg_env" {
  source    = "./modules/resource_group"
  
  rg_name   = var.rg_name
  location  = var.location
}

# App Service Plan
module "plan" {
  source              = "./modules/app_service_plan"
  name                = var.plan_name
  resource_group_name = var.rg_name
  location            = var.location

    depends_on = [
    module.rg_env  # ✅ Dépend directement du module resource_group
  ]
}

# Web App Service
module "webapp" {
  source              = "./modules/web_app"
  name                = var.web_app_name
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = module.plan.plan_id

    depends_on = [
    module.rg_env  # ✅ Dépend directement du module resource_group
  ]
}

# database
module "db" {
  source              = "./modules/database"
  server_name         = var.db_server_name
  db_name             = var.db_name
  resource_group_name = var.rg_name
  location            = var.db_location 
  admin_password      = var.db_password 

    depends_on = [
    module.rg_env  # ✅ Dépend directement du module resource_group
  ]
}