# ---------------------------------------------------------------------
# rides - menu
# ---------------------------------------------------------------------

# manage rides menu
get "/rides" do
  erb :"/rides/manage_rides"
end

# ---------------------------------------------------------------------
# create
# ---------------------------------------------------------------------

# form for user to enter information to add ride
get "/add_ride_form" do
  erb :"/rides/add_ride_form"
end

# Gets parameters from add_ride_form.
#
# Adds ride to table
get "/add_ride" do
  if Ride.valid?(params["cyclist_id"], params["bike_id"], params["miles"])
    erb :"/rides/add_ride_error"
  else
    Ride.add_to_database("cyclist_id" => params["cyclist_id"], "bike_id" => params["bike_id"], "ride_name" => params["ride_name"], "miles" => params["miles"])
    erb :"/rides/success"
  end
end

# ---------------------------------------------------------------------
# read
# ---------------------------------------------------------------------

# Returns a list of all rows in the rides table.
get "/view_rides" do
  erb :"/rides/view_rides"
end

# form to enter ride id
get "/rides/search_by_id_form" do
  erb :"/rides/search_by_id_form"
end

# Returns user profile
get "/rides/search_by_id/" do
  @new_ride = Ride.find(params["id"])
  erb :"/rides/search_by_id"
end

# Google Maps API attempt
get "/calculate_ride_form" do
  erb :"/rides/calculate_ride_form"
end

get "/calculate_ride" do
  distance_hash = {:query=>
    {"origin"=> params["origin"],
     "destination"=> params["destination"],
     "mode"=>"bicycling",
     "key"=>"AIzaSyB3DLdYmSzi0BBgBZPiqKy_qQLFCBisLyw"}}
  response = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json", distance_hash)
  @distance = response["routes"][0]["legs"][0]["distance"]["text"]
  erb :"/rides/calculate_ride"
 end

# ---------------------------------------------------------------------
# update
# ---------------------------------------------------------------------

# table of ride profiles
get "/edit_ride_list" do
  erb :"/rides/edit_ride_list"
end

# edit rides form
get "/edit_ride_form/:x" do
  @new_ride = Ride.find(params["x"])
  erb :"/rides/edit_ride_form"
end

# Gets parameters from edit_ride_form
#
# Updates the item in the appropriate table of the database
get "/edit_ride" do
  @new_ride = Ride.find(params["x"])
  @new_ride.ride_name = params["ride_name"]
  @new_ride.miles = params["miles"]
  @new_ride.save

  erb :"/rides/success"
end

# ---------------------------------------------------------------------
# delete
# ---------------------------------------------------------------------

get "/delete_ride" do
  erb :"/rides/delete_ride"
end

get "/delete_ride/:x" do
  @specific_ride = Ride.find(params["x"])
  @specific_ride.delete_row

  erb :"/rides/success"
end
