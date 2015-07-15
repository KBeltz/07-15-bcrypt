require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Bike
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  

  attr_accessor :cyclist_id, :bike_name, :description
  attr_reader :id

  # Initializes a new Bike object
  #
  # id            - Integer id primary key created in the 'bikes' table
  # cyclist_id    - Integer containing the id of the cyclist who owns the bike
  # bike_name     - String containing the make/model/name of the bike
  # description   - (optional) String containing a description of the bike
  #
  # Returns a Bike object
  
  def initialize(options = {})
    
    # Example: {"id" => 1, "cyclist_id" => "3", "bike_name" => "Giant Revel I", "description" => "Matte grey MTB"}
    @id = options["id"]
    @cyclist_id = options["cyclist_id"]
    @bike_name = options["bike_name"]
    @description = options["description"]
 
  end
  
  # method to validate bike profiles before they are added to the database
  #
  # cyclist_id - Integer containing the cyclist id of the bike's owner
  # bike_name  - String containing the make/model/name of the bike
  #
  # Returns boolean
  def self.valid?(cyclist_id, bike_name)
    if cyclist_id.empty? || bike_name.empty?
      true
    end
  end 
  
  # Get all rides by a specific bike.
  #
  # Return 
  def rides_list
    DATABASE.execute("SELECT rides.ride_name, rides.miles FROM rides JOIN bikes ON rides.bike_id = bikes.id WHERE bikes.id = #{id}")
  end
  
end