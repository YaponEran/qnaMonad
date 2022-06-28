require "rails_helper"

RSpec.describe Operations::Answers::Create, type: :service do
  describe "#call" do
    let!(:question) { create(:question) }
    let!(:params) do
      {
        body: "New Answer body",
        question_id: question.id
      }
    end

    context "when all params correct" do
      it "returns success" do
        result = subject.call(params)
        
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(Answer)
      end

      it "creates new Answer" do
        expect { subject.call(params) }.to change{ Answer.count }.to(1)
      end
    end

    context "when params incorrect" do
      it "returns failure" do
        result = subject.call({body: ""})
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end

  end
end