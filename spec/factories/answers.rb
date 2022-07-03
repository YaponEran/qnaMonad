FactoryBot.define do
  factory :answer do
    body { 'Question Anwer' }
    question
    user
  end
end
