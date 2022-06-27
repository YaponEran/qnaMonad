# frozen_string_literal: true

module Validations
  module Question
    class Question < Validations::Base
      params do
        required(:title).filled(:string)
        required(:body).filled(:string)
      end
    end
  end
end
