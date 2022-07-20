module Operations
  module Answers
    class BestAnswer
      include Dry::Monads[:result, :do]

      def call(answer)
        answer = yield find_answer(answer)
        best_answer = yield find_best_answer
        yield set_best(answer, best_answer)

        Success(answer)
      end

      private

      def find_answer(answer)
        answer = Answer.find_by(id: answer.id)
        
        Success(answer)
      rescue ActiveRecord::RecordNotUnique
        Failure[:answer_not_found, {}]
      end

      def find_best_answer
        best_answer = Answer.find_by(best: true)

        Success(best_answer)
      rescue ActiveRecord::RecordNotUnique
        Failure[:best_answer_not_found, {}]
      end

      def set_best(answer, best_answer)
        best_answer&.update!(best: false)
        Answer.transaction do
          answer.update!(best: true)
        end

        Success()
      end
    end
  end
end