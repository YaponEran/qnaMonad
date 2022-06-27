# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Questions::Create, type: :service do
  describe '#call' do
    let!(:params) do
      {
        title: 'Mountain',
        body: 'How many picks have in Himalaya mounains?'
      }
    end

    context 'when params incorrect' do
      it 'return failure' do
        result = subject.call({ body: '' })

        expect(result.failure[0]).to eq(:validation_error)
      end
    end

    context 'when all params correct' do
      it 'returns Success' do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Success)
      end

      it 'creates Question' do
        expect { subject.call(params) }.to change { Question.count }.to(1)
      end
    end
  end
end
