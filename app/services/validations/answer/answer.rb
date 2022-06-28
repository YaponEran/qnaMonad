# frozen_string_literal: true

module Validations
    module Answer
      class Answer < Validations::Base
        params do
          required(:body).filled(:string)
          required(:question_id).filled(:integer)
        end
      end
    end
  end
  