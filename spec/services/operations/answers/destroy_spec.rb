require "rails_helper"

RSpec.describe Operations::Answers::Destroy, type: :service do 
  describe "#call" do
    let!(:answer) { create(:answer) }

    context "when all params correct" do
      it "returns success" do
        result = subject.call(answer)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "deletes answer" do
        expect{ subject.call(answer) }.to change{Answer.count}.by(-1)
      end
    end
  end
end