FactoryGirl.define do
  factory :profile do
    user nil
    location "MyString"
    transient do
      companies []
    end
    after(:create) do |profile, evaluator|
      evaluator.companies.each do |company|
        puts company, profile
        create(:working_history, profile_id: profile.id, company: company)
      end
    end
  end
end
