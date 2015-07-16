# ---------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------
get "/" do
  @page_title = "Home"
  erb :"/main/home"
end

get "/new" do
  @page_title = "Sign Up for an Account"
  erb :"/main/new"
end

get "/login" do
  @page_title = "User Login"
  erb :"/main/login"
end

get "/login_attempt"
  pass_attempt = params["password"]
  stored_pass = BCrypt::Password.new(password-from-database)

  if stored_pass == pass_attempt
    erb :"/main/success"
  else
    erb :"/main/login_error"
  end
end
