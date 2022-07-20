module Operations
  module Answers
    class Destroy
      include Dry::Monads[:result, :do]

      def call(answer)
        answer = yield check_answer(answer)
        yield commit(answer)
        
        Success()
      end

      private

      def check_answer(answer)
        answer = Answer.find_by(id: answer.id)

        Success(answer)
      rescue ActiveRecord::RecordNotUnique
        Failure[:answer_not_found, {}]
      end

      def commit(answer)
        answer.destroy!
        Success()
      end
    end
  end
end