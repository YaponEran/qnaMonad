# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Questions::Destroy, type: :service do
  describe '#call' do
    let!(:question) { create(:question) }
    context 'whean al params correct' do
      it 'returns Success' do
        result = subject.call(question)

        expect(result).to be_a(Dry::Monads::Success)
      end

      it 'Deleted question' do
        expect { subject.call(question) }.to change { Question.count }.by(-1)
      end
    end
  end
end
