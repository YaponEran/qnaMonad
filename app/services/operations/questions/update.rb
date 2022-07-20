# frozen_string_literal: true

module Operations
  module Questions
    class Update
      include Dry::Monads[:result, :do]

      def call(question, params)
        validated_params = yield validate(params.to_h)
        yield check_question(question)
        result = yield commit(question, params.to_h)
        Success(question)
      end

      private

      def validate(params)
        validation = Validations::Question::Question.new
        validation.call(params)
      end

      def check_question(question)
        question = Question.find_by(id: question.id)
        if question
          Success(question)
        else
          Failure[:question_not_found, {}]
        end
      end

      def commit(question, params)
        result = question.update!(params)

        Success(result)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end
