module Operations
  module Questions
    class Create
      include Dry::Monads[:result, :do]

      def call(params)
        validated_params = yield validate(params)
        question = yield commit(validated_params.to_h)
        Success(question)
      end

      private

      def validate(params)
        validation = Validations::Question::Question.new
        validation.call(params)
      end

      def commit(params)
        question = Question.create!(params)

        Success(question)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end

    end
  end
end