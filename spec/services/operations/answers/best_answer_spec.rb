require 'rails_helper'

RSpec.describe Operations::Answers::BestAnswer, type: :service do
  describe '#call' do
    let!(:answer) { create(:answer) }
    let!(:answer2) { create(:answer, best: true) }
    context "When all params correct" do
      it "returns success" do
        result = subject.call(answer)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it"updates answer best value" do
        result = subject.call(answer)
        expect(result.value!.best).to eq(true)
      end
    end
  end
end