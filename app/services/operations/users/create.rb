module Operations
  module Users
    class Create
      include Dry::Monads[:result, :do]

      def call(params)
        validated_params = yield validate(params.to_h)
        user = yield commit(params)

        Success(user)
      end

      private

      def validate(params)
        validation = Validations::User::User.new
        validation.call(params)
      end

      def commit(params)
        user = User.create!(params)
        Success(user)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end