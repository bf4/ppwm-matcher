require 'yaml'
db_config_filename = 'config/database.yml'
db_name = YAML.load(File.read("./#{db_config_filename}"))['development']['database']
puts "Initializing and migrating postgresql db #{db_name}"
`createdb #{db_name} && rake db:migrate`
