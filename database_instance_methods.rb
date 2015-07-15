require "active_support"
require "active_support/inflector"
 
module DatabaseInstanceMethods
  
  # Determines appropriate table name 
  #
  # Gets class name from self.class
  # 
  # Returns String containing corresponding table name
  def get_table_name
    self.class.to_s.pluralize.underscore
  end
 
  # delete - delete row of object in table according to saved ID in instance.
  # 
  # Returns nil because row is deleted. 
  def delete_row
    DATABASE.execute("DELETE FROM #{get_table_name} WHERE id = #{@id};")
  end
  
  # Takes instance variables, splits them into key/value pairs and puts them
  #   in a Hash
  #
  # Returns Hash
  def create_attribute_hash
    instance_variables = self.instance_variables
    attribute_hash = {}

    instance_variables.each do |variable|
      attribute_hash["#{variable.slice(1..-1)}"] = self.send("#{variable.slice(1..-1)}")
    end
    return attribute_hash
  end
  
  # Necessary to quote-ify Strings properly and leave other stuff alone.
  #
  # attribute_hash - Hash of attributes
  #
  # Returns a String of instance variables
  def sql_variables(attribute_hash)
    individual_instance_variables = []

    attribute_hash.each do |key, value|
      if value.is_a?(String)
        individual_instance_variables << "#{key} = '#{value}'"
      else
        individual_instance_variables << "#{key} = #{value}"
      end
    end

    for_sql = individual_instance_variables.join(', ')
    return for_sql
  end
   
  # Updates/saves a row's information in a table
  #
  # Returns updated Object
  def save
    DATABASE.execute("UPDATE #{get_table_name} SET #{sql_variables(create_attribute_hash)} WHERE id = #{self.id}")
    return self
  end
end