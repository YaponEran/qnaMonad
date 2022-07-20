module Operations
  module Comments
    class Create
      include Dry::Monads[:result, :do]

      def call(type, params, user)
        validated_params = yield validate(params.to_h)
        user = yield check_user(user)
        yield commit(type, validated_params.to_h.merge(user_id: user.id))

        Success()
      end

      private

      def validate(params)
        validations = Validations::Comment::Comment.new
        validations.call(params)
      end

      def check_user(user)
        user = User.find_by(id: user.id)

        Success(user)
      rescue ActiveRecord::RecordNotUnique
        Failure[:user_not_found, {}]
      end

      def commit(type, params)
        comment = type.comments.create!(params.to_h)
        Success()
      end
    end
  end
end