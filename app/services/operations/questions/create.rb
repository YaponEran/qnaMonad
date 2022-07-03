# frozen_string_literal: true

module Operations
  module Questions
    class Create
      include Dry::Monads[:result, :do]

      def call(params, user)
        validated_params = yield validate(params.to_h)
        user = yield check_user(user)
        question = yield commit(validated_params.to_h.merge(user_id: user.id))
        Success(question)
      end

      private

      def validate(params)
        validation = Validations::Question::Question.new
        validation.call(params)
      end

      def check_user(user)
        user = User.find_by(id: user.id)

        Success(user)
      rescue ActiveRecord::RecordNotUnique
        Failure[:user_not_found]
      end

      def commit(params)
        question = Question.create!(params.to_h)

        Success(question)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end
