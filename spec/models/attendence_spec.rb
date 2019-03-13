require 'rails_helper'

RSpec.describe Attendence, type: :model do

  # before do
  #   @attendences = []
  #
  #   @attendences << Attendence.create!(user_id: @user.id)
  #   @attendences << Attendence.create!(user_id: @user.id)
  #   @attendences << Attendence.create!(user_id: @user.id)
  #
  #   [ 1.hour.ago, 5.minutes.ago, 1.minute.ago ].each_with_index do |time, index|
  #     attendence = @attendences[index]
  #     attendence.created_at = time
  #     attendence.save
  #   end
  # end



  describe "Attendence" do
    let(:user) {FactoryBot.create(:user)}
    let(:attendence_1) {FactoryBot.create(:attendence, user_id: user.id)}
    let(:attendence_2) {FactoryBot.create(:attendence, user_id: user.id)}

    context "associations" do
      it {should belong_to(:user)}
    end

    context "nil user" do
      it "doesn't allow nil user" do
        expect(FactoryBot.build(:attendence, user_id: nil)).not_to eq true 
      end
    end

    context "default scope" do
      it "orders by descending created_at" do
        expect(Attendence.all.to_sql).to eq Attendence.all.order(created_at: :desc).to_sql
      end
      # it 'should be correctly ordered' do
      #   @sorted_attendences = Attendence.all
      #   @attendences.first.should == @sorted_attendences.last
      #   @attendences.second.should == @sorted_attendences.second
      #   @attendences.third.should == @sorted_attendences.first
      # end
    end

  end

end
