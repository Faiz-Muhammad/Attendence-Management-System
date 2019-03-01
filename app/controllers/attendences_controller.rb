class AttendencesController < ApplicationController

  before_action :set_attendence, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user_for_attendence, only: [:edit, :update]
  before_action :require_same_user_for_not_showing_others_attendence, only: [:index]
  before_action :require_admin, only: [:destroy]
  after_action  :set_hours_and_month, only: [:update]
  # before_action :checking_check_in_date, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @attendences = @user.attendences.all
  end

  def new
    @attendence = current_user.attendences.new
  end

  def create
    @attendence = current_user.attendences.build(attendence_params)
    if @attendence.date == Date.today
      if @attendence.save
        flash[:success] = "Attendence marked successfully!"
        redirect_to user_attendences_path
      else
        render 'new'
      end
    else
      flash[:danger] = "You can only mark today's attendance."
      redirect_to root_path
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
    params.require(:attendence).permit(:date, :reason, :check_in, :check_out, :month, :check_in_flag, :hours, :user_id)
  end

  def set_attendence
    @attendence = Attendence.find_by(id: params[:id])
  end

  def set_hours_and_month
    current_user.attendences.first.update_attribute(:hours, hours_in_a_day(current_user.attendences.first))
    current_user.attendences.first.update_attribute(:month, Time.now.strftime("%B"))
  end

  def require_same_user_for_not_showing_others_attendence
    if current_user.id != params[:user_id].to_i && !current_user.admin?
      flash[:danger] = "You can only edit or view your own information."
      redirect_to root_path
    end
  end

  def require_same_user_for_attendence
    if (current_user.attendences.first.id != @attendence.id)
      flash[:danger] = "Only admin user can perform this action."
      redirect_to root_path
    end
  end

end
