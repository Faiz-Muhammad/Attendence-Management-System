FactoryBot.define do
  factory :attendence do
    association :user
    date  {Date.today}
    reason {FFaker::Lorem.sentence}
    month {Time.now.strftime("%B")}
    check_in {FFaker::Time.between(2.days.ago, Time.now)}
    check_out {FFaker::Time.between(2.days.ago, Time.now)}
    hours {rand(1...10)}
    check_in_flag { false }
  end
end
