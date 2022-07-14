module Terra
  class CommentsController < BaseController
    before_action :authenticate_user!
    

    def create
      operation = Operations::Comments::Create.new
      result = operation.call(commentable_type, comment_params, current_user)

      case result
      in Success
        flash[:notice] = "Comment successfuly created"
        redirect_to terra_question_path(commentable_type)
      in Failure[error, payload]
        flash[:error] = "While create comment went wrong: #{error} - #{payload}"
        redirect_to terra_question_path(commentable_type)
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def commentable_type
      klass = [Question, Answer].find {|k| params["#{k.name.underscore}_id"]}
      klass.find(params["#{klass.name.underscore}_id"])
    end
  end
end