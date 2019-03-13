require 'rails_helper'

RSpec.describe HomesController, type: :controller do

# <---------------------------INDEX ACTION TESTS--------------------------->

  describe "#index" do
    let(:user) {FactoryBot.create(:user)}

    context "as an authenticate user" do
      it "responds successfully" do
        sign_in user
        get :index
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        sign_in user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "as an unauthenticate user" do
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end

  end

end
