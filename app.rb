require "pry"
require "sinatra"
require "sinatra/reloader"
require "HTTParty"
require "bcrypt"

# SQL/Database
require "sqlite3"
require_relative "database_setup.rb"

# Models
require_relative "models/cyclist.rb"
require_relative "models/bike.rb"
require_relative "models/ride.rb"

# Controllers
require_relative "controllers/main.rb"
require_relative "controllers/cyclists.rb"
require_relative "controllers/bikes.rb"
require_relative "controllers/rides.rb"
