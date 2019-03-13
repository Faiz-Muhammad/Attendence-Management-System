class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :lockable, :timeoutable,
         :recoverable, :rememberable, :validatable, :trackable

  has_attached_file :image, styles: { medium: "300x300>", thumb: "50x50#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :phonenumber, length: { maximum: 13 }
  has_many :attendences

  def update_user
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      @user.update_without_password(user_params)
    elsif !(user_params[:password].blank? && user_params[:password_confirmation].blank?)
      @user.update_attributes(user_params)
    end
  end
end
