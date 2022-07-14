require "rails_helper"

RSpec.describe Operations::Comments::Create, type: :service do
  describe "#call" do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }
    let!(:params) do
      {
        body: "Q ot A comment body"
      }
    end
    context "When all params is correct" do
      it 'returns success' do
        result = subject.call(question, params, user)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "creates a comments" do
        expect{ subject.call(question, params, user) }.to change { Comment.count }.by(1)
      end
    end

    context "When params inccorect" do
      it "return a failure" do
        result = subject.call(question, nil, user)

        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end
  end
end