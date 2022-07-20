require "rails_helper"

RSpec.describe Operations::Comments::Destroy, type: :service do
  describe "#call" do
    let!(:comment) { create(:comment) }
    context "When all params correct" do
      it "returns success" do
        result = subject.call(comment)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "Deletes comment" do
        expect{ subject.call(comment) }.to change { Comment.count }.by(-1)
      end
    end
  end
end