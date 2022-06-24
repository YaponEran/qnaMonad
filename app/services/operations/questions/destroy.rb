module Operations
  module Questions
    class Destroy
      include Dry::Monads[:result, :do]

      def call(rescource)
        yield check_question(rescource)
        result = yield commit(rescource)
        Success(result)
      end

      private

      def check_question(question)
        @question = Question.find_by(id: question.id)

        Success(@question)
      rescue ActiveRecord::RecordNotUnique
        Failure[:question_not_found, {}]
      end

      def commit(question)
        question.destroy!
        Success()
      end

    end
  end
end