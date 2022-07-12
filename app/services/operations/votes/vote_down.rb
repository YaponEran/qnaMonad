module Operations
  module Votes
    class VoteDown
      include Dry::Monads[:result, :do]

      def call(type, user)
       user = yield check_user(user)

       vote_down = yield commit(type, user)

       Success(vote_down)
      end

      private

      def check_user(user)
        user = User.find_by(id: user.id)

        Success(user)
      rescue ActiveRecord::RecordNotUnique
        Failure[:user_not_found, {}]
      end

      def vote_author?(user, voted_author)
        user == voted_author
      end

      def voted?(type, vote_author)
        type.votes.exists?(user: vote_author)
      end

      def type_rate_subtract(type)
        rate_subtract = type.rate -= 1
        type.update!(rate: rate_subtract)
      end

      def commit(type, user)
        if vote_author?(user, type.user)
          Failure["you are an author of: #{type.class}", {}]
        elsif voted?(type, user)
          Failure["you already voted to: #{type.class}", {}]
        else
          type.votes.update(user: user, value: 0)
          type_rate_subtract(type)
          Success()
        end
      end
    end
  end
end