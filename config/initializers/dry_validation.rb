require "dry/monads/result"

module Dry
  module Validation
    class Result
      include Dry::Monads::Result::Mixin

      def to_monad
        success? ? Success(self) : Failure([:validation_error, errors.to_h])
      end
    end
  end
end