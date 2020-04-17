# configuration for application sets 
rg_app = {
    web_tier    = {
        name = "-app-frontend" 
    }
    app_tier = {
        name = "-app-application"
    }
    db_tier = {
        name = "-app-database"
    }
}

web_tier = {
    as = {
        name = "as-web" 
        tags = {  
            tier = "web" 
        }
    }
    lb = {
        name = "ilb-web"
        frontend_name  = "PrivateIPAddress-ilb-web"
        tags = {  
            tier = "web" 
        }
    }   
}

app_tier = {
    as = {
        name = "as-app" 
        tags = {  
            tier = "app" 
        }
    }
    lb = {
        name = "ilb-app"
        frontend_name  = "PrivateIPAddress-ilb-app"
        tags = {  
            tier = "app" 
        }
    }   
}

db_tier = {
    as = {
        name = "as-db" 
        tags = {  
            tier = "db" 
        }
    }
    lb = {
        name = "ilb-app"
        frontend_name  = "PrivateIPAddress-ilb-db"
        tags = {  
            tier = "db" 
        }
    }   
}

