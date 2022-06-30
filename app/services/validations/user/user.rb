module Validations
  module User
    class User < Validations::Base
      params do
        required(:firts_name).filled(:string)
        required(:last_name).filled(:string)
        required(:country).filled(:string)
        required(:password).filled(:string)
        required(:email).filled(:string)
      end

      rule(:email) do
        key(:email).failure("email not valid") unless value.include?("@")
      end
    end
  end
end