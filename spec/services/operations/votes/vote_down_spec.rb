require 'rails_helper'

RSpec.describe Operations::Votes::VoteDown, type: :service do
  describe '#call' do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:question) { create(:question, rate: 1, user: user2) }

    let!(:vote) { create(:vote, user: user) }
    let!(:question_with_vote) { create(:question, rate: 1, votes: [vote], user: user2 ) }

    context "When all params correct" do
      it "returns success" do
        result = subject.call(question, user)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "subtracts rate cvalue" do
        expect{subject.call(question, user)}.to change { question.rate }.by(-1)
      end
    end

    context "When params incorrect" do
      it "returns failure" do
        result = subject.call(question, user2)

        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq("you are an author of: #{question.class}")
      end
    end

    context "When user already voted" do
      it "returns failure" do
        result = subject.call(question_with_vote, user)
        
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq("you already voted to: #{question.class}")
      end
    end
  end
end