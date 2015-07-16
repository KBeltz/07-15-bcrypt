# Is this going to work if it is just added in the cyclist model?

class User
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render action: "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
