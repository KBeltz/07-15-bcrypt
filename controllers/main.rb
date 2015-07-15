# ---------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------
get "/" do
  @page_title = "Home"
  erb :"/main/home"
end

get "/new" do
  erb :"/main/new"
end

get "/login" do
  erb :"/main/login"
end
