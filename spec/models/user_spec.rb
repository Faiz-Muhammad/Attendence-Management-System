require 'rails_helper'

RSpec.describe User, type: :model do


  describe "User" do
    let(:user) {FactoryBot.create(:user)}

    context "associations" do
      it {should have_many(:attendences)}
    end

    context "validations" do
      context "presence" do
        it { should validate_presence_of :email }
      end

      context "uniqueness" do
        it { should validate_uniqueness_of(:email).case_insensitive }
      end

      context "valid phonenumber length" do
        it "has a valid length" do
          len = Math.log10(user.phonenumber).to_i + 1
          y = 13
          expect(len < y).to eq true
        end
      end
    end

    context "valid Factory" do
      it "has a valid factory" do
        expect(FactoryBot.build(:user)).to be_valid
      end
    end

    context "Image attachment" do
      it "should check attached image" do
        im = File.open('public/images/medium/missing.png')
        user.image = im
        user.save!
        im.close
        expect(user.image.exists?).to eq true
      end
    end

  end




  # it "is valid with a name, phone number, role, email and password" do
  #   user = User.new(
  #     name: "name",
  #     phonenumber: "032111111111",
  #     role: "role",
  #     email: "test@example.com",
  #     password: "somePassword",
  #   )
  #   expect(user).to be_valid
  # end
  #
  # it "is invalid without an email" do
  #   user = User.new(email: nil)
  #   user.valid?
  #   expect(user.errors[:email]).to_not include("Can't be blank")
  # end
  #
  # it "is invalid with a duplicate email address" do
  #   User.create(
  #     email: "tester@example.com",
  #     password: "anything",
  #   )
  #   user = User.new(
  #     email: "tester@example.com",
  #     password: "anything",
  #   )
  #   user.valid?
  #   expect(user.errors[:email]).to include("has already been taken")
  # end

end
