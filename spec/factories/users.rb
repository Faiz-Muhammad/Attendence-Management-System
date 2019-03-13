
FactoryBot.define do
  factory :user do
    name {FFaker::Name.name}
    phonenumber {FFaker::PhoneNumber.phone_number}
    role {FFaker::Lorem.sentence}
    email {FFaker::Internet.email }
    password {"123456" }
    password_confirmation { "123456" }
    image { nil }
    admin { false }

    # factory :user_with_attendences do
    #   # transient do
    #   #   attendences_count 5
    #   # end
    # 
    #   after(:create) do |user, evaluator|
    #     create_list(:attendence, 5, user: user)
    #   end
    # end
  end
end
