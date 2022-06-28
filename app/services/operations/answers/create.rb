module Operations
  module Answers
    class Create
      include Dry::Monads[:result, :do]

      def call(question, params)
        validated_params = yield validate(params.to_h)
        question = yield check_question(question)
        answer = yield commit(question, params)

        Success(answer)
      end

      private

      def validate(params)
        validation = Validations::Answer::Answer.new
        validation.call(params)
      end

      def check_question(question)
        @question = Question.find_by(id: question.id)

        Success(@question)
      rescue ActiveRecord::RecordNotUnique
        Failure[:question_not_found, {}]
      end

      def commit(question, params)
        answer = question.answers.create(params)

        Success(answer)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end