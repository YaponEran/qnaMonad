module Validations
  module Vote
    class Vote < Validations::Base
      params do
        required(:value).filled(:integer)
      end
    end
  end
end