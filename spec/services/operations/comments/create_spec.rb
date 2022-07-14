require "rails_helper"

RSpec.describe Operations::Comments::Create, type: :service do
  describe "#call" do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }
    let!(:params) do
      {
        user_id: user.id,
        body: "Q ot A comment body"
      }
    end
    context "When all params is correct" do
      it 'returns success' do
        result = subject.call(question, params, user)
      end
    end
  end
end