class AttendencesController < ApplicationController

  # before_action :set_attendence, only: [:show, :edit, :update, :destroy]
  # before_action :require_same_user_and_attendence, only: [:edit, :update]
  # before_action :require_same_user, only: [:index]
  # before_action :require_admin, only: [:destroy]

  def index
    @user = User.find(params[:user_id])
    @attendences = @user.attendences.all
  end

  def new
    @attendence = current_user.attendences.new
  end

  def create
    @attendence = current_user.attendences.build(attendence_params)
    if @attendence.save
      flash[:success] = "Attendence marked successfully!"
      redirect_to user_attendences_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @attendence.update(attendence_params)
      flash[:success] = "Your check out was marked successfully"
      redirect_to user_attendence_path(current_user,@attendence)
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    @attendence.destroy
    redirect_to user_attendences_path(current_user)
  end

  private
  def attendence_params
    params.require(:attendence).permit(:date, :reason, :check_in, :check_out, :month, :check_in_flag, :user_id)
  end

  def set_attendence
    @attendence = Attendence.find_by(id: params[:id])
  end

end
