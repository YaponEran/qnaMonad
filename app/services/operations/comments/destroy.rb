module Operations
  module Comments
    class Destroy
      include Dry::Monads[:result, :do]

      def call(comment)
        comment = yield check_comment(comment)
        yield commit(comment)

        Success()
      end

      private

      def check_comment(comment)
        comment = Comment.find_by(id: comment.id)

        Success(comment)
      rescue ActiveRecord::RecordNotUnique
        Failure[:comment_not_found, {}]
      end

      def commit(comment)
        comment.destroy!
        Success()
      end
    end
  end
end