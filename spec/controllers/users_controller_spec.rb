require 'rails_helper'

RSpec.describe UsersController, type: :controller do

# <---------------------------INDEX ACTION TESTS--------------------------->

  describe "#index" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
    end

    context "as an authorized user(user index)" do

      it "responds successfully, when admin" do
        sign_in @user_1
        get :index
        expect(response).to be_successful
      end

      it "doesn't responds, when not admin" do
        sign_in @user_2
        get :index
        expect(response).not_to be_successful
      end
    end

    context "as an unauthorized user(user index)" do

      it "redirects to home page, when employee" do
        sign_in @user_2
        get :index
        expect(response).to redirect_to root_path
      end
    end
  end

# <---------------------------NEW ACTION TESTS--------------------------->

  describe "#new" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
    end

    context "as an authorized user(user new)" do

      it "responds successfully, when admin" do
        sign_in @user_1
        get :new
        expect(response).to be_successful
      end

      it "doesn't responds, when not admin" do
        sign_in @user_2
        get :new
        expect(response).not_to be_successful
      end
    end

    context "as an unauthorized user(user new)" do

      it "redirects to home page, when employee" do
        sign_in @user_2
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

# <---------------------------CREATE ACTION TESTS--------------------------->

  describe "#create" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
    end

    context "as an authorized user(user create)" do

      it "doesn't responds, when not admin" do
        user_params = FactoryBot.attributes_for(:user)
        sign_in @user_2
        post :create, params: {user: user_params}
        expect(response).not_to be_successful
      end

      it "creates employee, when admin" do
        user_params = FactoryBot.attributes_for(:user)
        sign_in @user_1
        post :create, params: {user: user_params}
        expect(assigns[:user]).to be_present
      end
    end

    context "as an unauthorized user(user create)" do

      it "redirects to home page, when employee" do
        user_params = FactoryBot.attributes_for(:user)
        sign_in @user_2
        post :create, params: {user: user_params}
        expect(response).to redirect_to root_path
      end
    end
  end

# <---------------------------EDIT ACTION TESTS--------------------------->

describe "#edit" do
  before(:each) do
    @user_1 = FactoryBot.create(:user, admin: true)
    @user_2 = FactoryBot.create(:user)
  end

  context "as an authorized user(user edit)" do

    it "responds successfully, when admin" do
      sign_in @user_1
      get :edit, params: {id: @user_2.id}
      expect(response).to be_successful
    end

    it "responds successfully, when not admin and same user" do
      sign_in @user_2
      get :edit, params: {id: @user_2.id}
      expect(response).to be_successful
    end
  end

  context "as an unauthorized user(user edit)" do
    before do
      @user_3 = FactoryBot.create(:user)
    end

    it "redirects to home page, when not same user" do
      sign_in @user_2
      get :edit, params: {id: @user_3.id}
      expect(response).to redirect_to root_path
    end

    it "doesn't responds, when not same user and not admin" do
      sign_in @user_2
      get :edit, params: {id: @user_3.id}
      expect(response).not_to be_successful
    end
  end
end

# <---------------------------UPDATE ACTION TESTS--------------------------->

  describe "#update" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
    end

    context "as an authorized user(user update)" do

      it "updates user successfully, when not admin and same user" do
        user_params = FactoryBot.attributes_for(:user, name: "updated name")
        sign_in @user_2
        patch :update, params: {id: @user_2.id, user: user_params}
        expect(@user_2.reload.name).to eq "updated name"
      end

      it "updates employee successfully, when admin" do
        user_params = FactoryBot.attributes_for(:user, name: "changed name")
        sign_in @user_1
        patch :update, params: {id: @user_2.id, user: user_params}
        expect(@user_2.reload.name).to eq "changed name"
      end
    end

    context "as an unauthorized user(user update)" do
      before do
        @user_3 = FactoryBot.create(:user)
      end
      it "redirects to home page, when not same user" do
        user_params = FactoryBot.attributes_for(:user, name: "update")
        sign_in @user_2
        patch :update, params: {id: @user_3.id, user: user_params}
        expect(response).to redirect_to root_path
      end
    end
  end

# <---------------------------SHOW ACTION TESTS--------------------------->

  describe "#show" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
    end

    context "as an authorized user(user show)" do

      it "responds successfully, when admin" do
        sign_in @user_1
        get :show, params: {id: @user_2.id}
        expect(response).to be_successful
      end

      it "responds successfully, when not admin and same user" do
        sign_in @user_2
        get :show, params: {id: @user_2.id}
        expect(response).to be_successful
      end
    end

    context "as an unauthorized user(user show)" do
      before do
        @user_3 = FactoryBot.create(:user)
      end

      it "redirects to home page, when not same user" do
        sign_in @user_2
        get :show, params: {id: @user_3.id}
        expect(response).to redirect_to root_path
      end

      it "doesn't responds, when not same user and not admin" do
        sign_in @user_2
        get :show, params: {id: @user_3.id}
        expect(response).not_to be_successful
      end
    end
  end

# <---------------------------DESTROY ACTION TESTS--------------------------->

  describe "#destroy" do
    before(:each) do
      @user_1 = FactoryBot.create(:user, admin: true)
      @user_2 = FactoryBot.create(:user)
      user_params = @user_2.attributes
    end

    context "as an authorized user(user destroy)" do

      it "deletes the user account, when admin" do
        sign_in @user_1
        expect {
          delete :destroy, params: {id: @user_2.id}
        }.to change(User, :count).by(-1)
      end

      it "redirects to the home page" do
        sign_in @user_1
        delete :destroy, params: { id: @user_2.id }
        expect(response).to redirect_to users_path
      end
    end

    context "as an unauthorized user(user destroy)"do
      before do
        @user_3 = FactoryBot.create(:user)
      end
      it "doesn't responds, when not admin" do
        sign_in @user_2
        delete :destroy, params: { id: @user_3}
        expect(response).not_to be_successful
      end
    end
  end


end
