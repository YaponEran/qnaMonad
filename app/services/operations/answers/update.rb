module Operations
  module Answers
    class Update
      include Dry::Monads[:result, :do]

      def call(answer, params)
        validated_params = yield validate(params.to_h)
        answer = yield check_answer(answer)
        result = yield commit(answer, validated_params)
        Success(answer)
      end

      private

      def validate(params)
        validation = Validations::Answer::Update.new
        validation.call(params)
      end

      def check_answer(answer)
        answer = Answer.find_by(id: answer.id)

        Success(answer)
      rescue ActiveRecord::RecordNotUnique
        Failure[:answer_not_found, {}]
      end

      def commit(answer, params)
        answer.update!(params.to_h)
        Success()
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end