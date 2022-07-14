module Validations
  module Comment
    class Comment < Validations::Base
      params do 
        required(:body).filled(:string)
      end
    end
  end
end