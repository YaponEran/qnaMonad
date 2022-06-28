require "rails_helper"

RSpec.describe Operations::Answers::Update, type: :service do
  describe "#call" do
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer) }
    let(:params) do
      {
        body: "Updated answer body",
        question_id: question.id
      }
    end

    context "when params incorrect" do
      it "returns failure" do
        result = subject.call(answer, { body: "" })
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end

    context "When all params is correct" do
      it "returns success" do
        result = subject.call(answer, params)

        expect(result).to be_a(Dry::Monads::Success)
      end
    end
  end
end