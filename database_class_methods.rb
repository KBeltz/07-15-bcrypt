require "active_support"
require "active_support/inflector"
 
module DatabaseClassMethods
  
  # Determines appropriate table name 
  #
  # Gets class name from self
  # 
  # Returns String containing corresponding table name
  def table_name
    self.to_s.pluralize.underscore
  end
  
  # Gets an array of hashes from the database and turns the hashes into objects
  #
  # results - Array of hashes, each hash containing one table row
  #
  # Returns an Array of objects
  def results_as_objects(results)
    array_of_objects = []

    results.each do |hash|
      array_of_objects << self.new(hash)
    end

    return array_of_objects
  end
  
  # Get all of the rows for a specific table.
  #
  # Returns an Array containing objects.
  def all
    results = DATABASE.execute("SELECT * FROM #{table_name}")
    object_list = results_as_objects(results)
  end
  
  # This method finds a product based on the ID in database and makes
  #   a new instance of row
  #
  # record_id - The Integer ID of the row to return.
  #
  #    # Here, I'm using the `find` method from DatabaseClassMethods.
  #    result = Product.find(product_id).first
  #    # {"id" => 1, "name" => "Sumeet", "age" => 500}
  #
  # Returns an object 
  def find(record_id)
    result = DATABASE.execute("SELECT * FROM #{table_name} WHERE id = #{record_id}").first
     
    self.new(result)
  end
 
  # Add a new record to the database.
  #
  # Returns an Object.
  def add_to_database(options={})
    
    column_names = options.keys
    values = options.values
    
    column_names_for_sql = column_names.join(", ")
    
    individual_values_for_sql = []
    
    values.each do |value|
      if value.is_a?(String)
        individual_values_for_sql << "'#{value}'"
      else  
        individual_values_for_sql << value
      end  
    end
    
    values_for_sql = individual_values_for_sql.join(", ")
    
    DATABASE.execute("INSERT INTO #{table_name} (#{column_names_for_sql}) VALUES (#{values_for_sql});")
 
    id = DATABASE.last_insert_row_id
    options["id"] = id
 
    self.new(options)
  end
end