module Operations
  module Votes
    class VoteUp
      include Dry::Monads[:result, :do]

      def call(type, user)
        user = yield check_user(user)
        
        vote = yield commit(type, user)

        Success(vote)
      end

      private
      def check_user(user)
        user = User.find_by(id: user.id)
        
        Success(user)
      rescue ActiveRecord::RecordNotUnique
        Failure[:user_not_found, {}]
      end

      def vote_author?(user, vote_author)
        user == vote_author
      end

      def voted?(type, vote_author)
        type.votes.exists?(user: vote_author)
      end

      def type_rate_incriment(type)
        rate_inciment = type.rate += 1
        type.update!(rate: rate_inciment)
      end

      def commit(type, user)
        if vote_author?(user, type.user)
          Failure["you are an author of: #{type.class}", {}]
        elsif voted?(type, user)
          Failure["you already voted to: #{type.class}", {}]
        else
          type.votes.create(user: user, value: 1)
          type_rate_incriment(type)
          Success()
        end
      end
    end
  end
end