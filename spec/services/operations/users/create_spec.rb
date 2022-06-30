require "rails_helper"

RSpec.describe Operations::Users::Create, type: :service do
  describe "#call" do
    let!(:params) do
      {
        firts_name: "Rovshen",
        last_name: "Gulamov",
        country: "Almaty",
        password: "1234567",
        email: "hello@mail.ru"
      }
    end
    context "When all params correct" do
      it "returns success" do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Success)
      end
    end
  end
end