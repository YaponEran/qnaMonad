# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Questions::Update, type: :service do
  describe '#call' do
    let!(:question) { create(:question) }
    let(:params) do
      {
        title: 'ewewew',
        body: 'W2wee3'
      }
    end

    context 'when params incorrect' do
      it 'returns failure' do
        result = subject.call(question, { body: '' })
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure[0]).to eq(:validation_error)
      end
    end

    context 'when all params correct' do
      it 'returns success' do
        result = subject.call(question, params)

        expect(result).to be_a(Dry::Monads::Success)
      end
    end
  end
end
