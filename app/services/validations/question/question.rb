# frozen_string_literal: true

module Validations
  module Question
    class Question < Validations::Base
      params do
        required(:title).filled(:string)
        required(:body).filled(:string)
        # for image just put filled as empty ot type []
        required(:images).filled()
      end
    end
  end
end
