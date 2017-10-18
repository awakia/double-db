FactoryGirl.define do
  factory :user do
    transient do
      location "location"
      companies []
    end
    sequence(:name) { |n| "User_#{n}" }
    after(:create) do |user, evaluator|
      create(:profile, user: user, location: evaluator.location, companies: evaluator.companies)
    end
  end
end
