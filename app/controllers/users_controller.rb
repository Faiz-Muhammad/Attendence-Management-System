class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
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
      flash[:success] = "Welcome #{@user.name} to Attendance Management System!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = "Employee account has beed updated successfully"
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
      flash[:danger] = "Employee and all associated records have been deleted"
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :phonenumber, :role, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

end
