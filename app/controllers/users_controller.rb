class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.xml  { render :xml => @user }
    # end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Successfully updated profile."
        redirect_to root_url
      else
        render :action => 'edit'
      end
    end
  end

  def confirm_registration
    @user = User.find(params[:id])
    if params[:token].present?  && params[:token] == @user.registration_token
      @user.registration_confirmed = true
      @user.registration_token = nil
      if @user.save
        flash[:notice] = "Registration Confirmed"
      else
        flash[:notice] = "Error"
      end
    else
      flash[:notice] = "Error"
    end
    redirect_to root_url
  end

  private ####################################################################

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end