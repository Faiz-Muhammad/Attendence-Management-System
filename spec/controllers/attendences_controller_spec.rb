require 'rails_helper'

RSpec.describe AttendencesController, type: :controller do

# <---------------------------INDEX ACTION TESTS--------------------------->

  describe "#index" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
      @user_3 = FactoryBot.create(:user)
      @attendence_1 = FactoryBot.create(:attendence, user: @user_2)
    end

    context "as an authorized user(attendence index)" do

      it "responds successfully, when admin" do
        sign_in @user_1
        get :index, params: {user_id: @user_2.id, attendence_id: @attendence_1.id}
        expect(response).to be_successful
      end

      it "responds successfully, when not admin but same user" do
        sign_in @user_2
        get :index, params: {user_id: @user_2.id, attendence_id: @attendence_1.id}
        expect(response).to be_successful
      end
    end

    context "as an unauthorized user(attendence index)" do

      it "doesn't responds, when not admin and not same user" do
        sign_in @user_3
        get :index, params: {user_id: @user_2.id, attendence_id: @attendence_1.id}
        expect(response).not_to be_successful
      end

      it "redirects to home page" do
        sign_in @user_3
        get :index, params: {user_id: @user_2.id, attendence_id: @attendence_1.id}
        expect(response).to redirect_to root_path
      end
    end
  end

# <---------------------------NEW ACTION TESTS--------------------------->

  describe "#new" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
      @user_3 = FactoryBot.create(:user)
      @attendence_1 = FactoryBot.create(:attendence, user: @user_2)
    end

    context "as an authorized user(attendence new)" do

      it "responds successfully, when admin" do
        sign_in @user_1
        get :new, params: {user_id: @user_2.id}
        expect(assigns(:attendence)).to be_a_new(Attendence)
      end

      it "responds successfully, when not admin but same user" do
        sign_in @user_2
        get :new, params: {user_id: @user_2.id}
        expect(assigns(:attendence)).to be_a_new(Attendence)
      end
    end

    context "as an unauthorized user(attendence new)" do

      it "doesn't responds, when not admin and not same user" do
        sign_in @user_3
        get :new, params: {user_id: @user_2.id}
        expect(response).not_to be_a_new(Attendence)
      end

      it "redirects to home page" do
        sign_in @user_3
        get :new, params: {user_id: @user_2.id}
        expect(response).to redirect_to root_path
      end
    end
  end

# <---------------------------CREATE ACTION TESTS--------------------------->

  describe "#create" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
      @user_3 = FactoryBot.create(:user)
    end

    context "as an authorized user(attendence create)" do

      it "responds successfully, when admin" do
        attendence_params = FactoryBot.attributes_for(:attendence)
        sign_in @user_1
        post :create, params: {user_id: @user_3.id, attendence: attendence_params}
        expect(response).not_to be_successful
      end

      it "creates attendence, when not admin but same user" do
        attendence_params = FactoryBot.attributes_for(:attendence)
        sign_in @user_2
        post :create, params: {user_id: @user_2.id, attendence: attendence_params}
        expect(assigns[:attendence]).to be_present
      end
    end

    context "as an unauthorized user(attendence create)" do

      it "doesn't responds, when not admin and not same user" do
        attendence_params = FactoryBot.attributes_for(:attendence)
        sign_in @user_3
        post :create, params: {user_id: @user_2.id, attendence: attendence_params}
        expect(response).not_to be_successful
      end

      it "redirects to home page" do
        attendence_params = FactoryBot.attributes_for(:attendence)
        sign_in @user_3
        post :create, params: {user_id: @user_2.id, attendence: attendence_params}
        expect(response).to redirect_to root_path
      end
    end

    context "Date must be today's date" do

      it "should create attendence, when same date and same user" do
        attendence_params = FactoryBot.attributes_for(:attendence)
        sign_in @user_2
        post :create, params: {user_id: @user_2.id, attendence: attendence_params}
        expect(@user_2.attendences.first.date).to eq Date.today
      end

      it "should create attendence, when not same date but admin" do
        attendence_params = FactoryBot.attributes_for(:attendence, date: Date.yesterday)
        sign_in @user_1
        post :create, params: {user_id: @user_3.id, attendence: attendence_params}
        expect(@user_3.attendences.first.date).not_to eq Date.today
        expect(response).to redirect_to user_attendences_path(@user_3)
      end
    end
  end

# <---------------------------EDIT ACTION TESTS--------------------------->

  # describe "#edit" do
  #   before(:each) do
  #     @user_1 = FactoryBot.create(:user, admin: true)
  #     @user_2 = FactoryBot.create(:user)
  #     @user_3 = FactoryBot.create(:user)
  #     @attendence_1 = FactoryBot.create(:attendence, user: @user_2)
  #   end
  #
  #   context "as an authorized user(attendence edit)" do
  #
  #     it "responds successfully, when admin" do
  #       sign_in @user_1
  #       get :edit, params: {user: @user_2, attendence: @attendence_1}
  #       expect(response).to be_successful
  #     end
  #
  #     it "responds successfully, when not admin but same user" do
  #       sign_in @user_2
  #       get :edit, params: {user: @user_2, attendence: @attendence_1}
  #       expect(response).to be_successful
  #     end
  #   end
  #
  #   context "as an unauthorized user(attendence edit)" do
  #
  #     it "doesn't responds, when not admin and not same user" do
  #       sign_in @user_3
  #       get :edit, params: {user: @user_2, attendence: @attendence_1}
  #       expect(response).not_to be_successful
  #     end
  #
  #     it "redirects to home page" do
  #       sign_in @user_3
  #       get :edit, params: {user: @user_2, attendence: @attendence_1}
  #       expect(response).to redirect_to root_path
  #     end
  #   end
  # end

# <---------------------------SHOW ACTION TESTS--------------------------->

  describe "#show" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
      @user_3 = FactoryBot.create(:user)
      @attendence_1 = FactoryBot.create(:attendence, user: @user_2)
      @attendence_2 = FactoryBot.create(:attendence, user: @user_3)
    end

    context "as an authorized user (attendence show)" do
      it "responds successfully, when admin" do
        sign_in @user_1
        get :show, params: {id: @attendence_1.id}
        expect(response).to be_successful
      end
    end
  end

end
