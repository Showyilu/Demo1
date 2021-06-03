FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    active { Faker::Boolean.boolean }
    complete { Faker::Boolean.boolean }
    user_id { create(:user).id }
  end
end
