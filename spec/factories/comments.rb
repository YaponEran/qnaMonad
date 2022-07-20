FactoryBot.define do
  factory :comment do
    body { "Some commentable comment body" }
    user
    association :commentable, factory: :question
  end
end
