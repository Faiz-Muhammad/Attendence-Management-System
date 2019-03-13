class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :edit, :update]
  before_action :require_same_user, only: [:edit, :update, :show]
  before_action :require_admin, only: [:destroy, :index, :new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New Employee account has been created successfully!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      @user.update_without_password(user_params)
      flash[:notice] = "#{@user.name}'s information has been updated."
      redirect_to user_path(@user)
    elsif !(user_params[:password].blank? && user_params[:password_confirmation].blank?)
      @user.update_attributes(user_params)
      sign_in(@user, :bypass => true)
      flash[:notice] = "#{@user.name}'s information has been updated."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    if !@user.admin?
      @user.destroy
      flash[:notice] = "Employee and all associated records have been deleted"
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :phonenumber, :image, :role, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit or view your own information."
      redirect_to root_path
    end
  end

end
