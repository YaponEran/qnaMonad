module Terra
  class CommentsController < BaseController
    before_action :authenticate_user!
    

    def create
      @question = Question.find_by(id: params[:question_id])
      operation = Operations::Comments::Create.new
      result = operation.call(commentable_type, comment_params, current_user)

      case result
      in Success
        flash[:notice] = "Comment successfuly created"
        if commentable_type.class.to_s == "Question"
          redirect_to terra_question_path(@question)
        elsif commentable_type.class.to_s == "Answer"
          redirect_to terra_question_path(commentable_type.question)
        end
      in Failure[error, payload]
        flash[:error] = "While create comment went wrong: #{error} - #{payload}"
        if commentable_type.class.to_s == "Question"
          redirect_to terra_question_path(@question)
        elsif commentable_type.class.to_s == "Answer"
          redirect_to terra_question_path(commentable_type.question)
        end
      end
    end

    def update
      @comment = Comment.find_by(id: params[:id])
      operation = Operations::Comments::Update.new
      result = operation.call(@comment, comment_params)

      case result
      in Success
        flash[:notice] = "Comment successfuly updated"
        redirect_to terra_question_path(@comment.user.questions.find_by(params[:question_id]))
      in Failure[error, payload]
        flash[:error] = "While create comment went wrong: #{error} - #{payload}"
        redirect_to terra_question_path(@comment.user.questions.find_by(params[:question_id]))
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