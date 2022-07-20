module Operations
  module Answers
    class Create
      include Dry::Monads[:result, :do]

      def call(params, user)
        validated_params = yield validate(params.to_h)
        user = yield check_user(user)
        question = yield check_question(validated_params[:question_id])
        answer = yield commit(validated_params.to_h.merge(user_id: user.id))
        
        # yield broadcat_answer_create_listener(user, question, validated_params[:body])

        Success(answer)
      end

      private

      def validate(params)
        validation = Validations::Answer::Answer.new
        validation.call(params)
      end

      def check_user(user_id)
        user = User.find_by(id: user_id)

        Success(user)
      rescue ActiveRecord::RecordNotUnique
        Failure[:user_not_found, {}]
      end

      def check_question(question_id)
        question = Question.find_by(id: question_id)

        Success(question)
      rescue ActiveRecord::RecordNotUnique
        Failure[:question_not_found, {}]
      end

      def commit(params)
        answer = Answer.create!(params.to_h)

        Success(answer)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end

      def broadcat_answer_create_listener(user, question, body)

        # ActionCable.server.broadcast("question_answers_#{question.id}", { user_id: user.id, question_id: question.id, body: body })
      end
    end
  end
end