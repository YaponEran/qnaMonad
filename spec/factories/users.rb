FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "userTest#{n}@mail.ru" }
    password { '1234567890' }
    sequence(:firts_name) { |n| "fn_#{n}" }
    sequence(:last_name) { |n| "ln_#{n}" }
  end
end
