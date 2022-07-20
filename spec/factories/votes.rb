FactoryBot.define do
  factory :vote do
    value { 0 }
    user
    association :votable, factory: :question
  end
end
