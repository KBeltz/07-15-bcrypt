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
