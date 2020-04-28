config = YAML.load_file("config/database.yml")
database = config[Rails.env]["database"]

raise if database != "imarket_development"
