module Operations
  module Comments
    class Update
      include Dry::Monads[:result, :do]

      def call(comment, params)
        validated_params = yield validate(params.to_h)
        comment = yield commit(comment, validated_params.to_h)

        Success(comment)
      end

      private

      def validate(params)
        validation = Validations::Comment::Comment.new
        validation.call(params)
      end

      def commit(comment, params)
        comment.update!(params)
        Success(comment)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end

    end
  end
end