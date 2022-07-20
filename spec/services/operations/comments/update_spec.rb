require "rails_helper"

RSpec.describe Operations::Comments::Update, type: :service do
  describe "#call" do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }
    let!(:comment) { create(:comment) }
    let!(:params) do 
      {
        body: "An updated comment body"
      }
    end

    context "When all params correct" do
      it "returns success" do
        result = subject.call(comment, params)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it "updated comment body" do
        result = subject.call(comment, params)
        expect(result.value!.body).to eq("An updated comment body")
      end
    end
  end
end