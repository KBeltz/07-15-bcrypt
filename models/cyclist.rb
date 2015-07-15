require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Cyclist < ActiveRecord::Base
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  include BCrypt

  # do I need to refactor this and have a separate user class or use this as the user model?
  attr_accessor :user_name, :password, :first_name, :last_name
  attr_reader :id

  # Initializes a new Cyclist object
  #
  # id         - Integer id primary key created in the 'cyclists' table
  # user_name  - String containing a unique user name
  # password   - String containing the user password
  # first_name - String containing the first name of the cyclist
  # last_name  - String containing the last name of the cyclist
  #
  # Returns a Cyclist object

  def initialize(options = {})
    # Example: {"id" => 1, "user_name" => "JohnBikes", "password" => "encrypted_string", "first_name" => "Johnny", "last_name" => "Doe"}
    @id = options["id"]
    @user_name = options["user_name"]
    @password = options["password"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # method to validate cyclist profiles before they are added to the database
  #
  # name1 - String containing the first name of the cyclist being added
  # name2 - String containing the last name of the cyclist being added
  #
  # Returns boolean
  def self.valid?(user_name, password)
    if user_name.empty? || password.empty?
      true
    end
  end

  # Get all bikes owned by a specific cyclist.
  #
  # Return
  def bikes_owned
    DATABASE.execute("SELECT bikes.bike_name FROM bikes JOIN cyclists ON bikes.cyclist_id = cyclists.id WHERE cyclists.id = #{id}")
  end

end
