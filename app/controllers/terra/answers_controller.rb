module Terra
  class AnswersController < BaseController

    def new
      @answer = Answer.new
    end

    def create
      @question = Question.find(params[:question_id])
      operation = Operations::Answers::Create.new
      result = operation.call(answer_params)

      case result
      in Success
        flash[:notice] = "Answer successfuly created"
        redirect_to terra_question_path(@question)
      in Failure[error, payload]
        flash[:error] = "Some thing went wrong"
        redirect_to terra_question_path(@question)
      end
    end

    def edit;end

    def update
      @answer = Answer.find_by(id: params[:id])
      operation = Operations::Answers::Update.new
      result = operation.call(@answer, answer_params)

      case result
      in Success
        flash[:notice] = "Answer successfuly updated"
        redirect_to terra_question_path(@answer.question)
      in Failure[error, payload]
        flash[:error] = "While update answer somethimg went wrog- #{error} : #{payload} "
        redirect_to terra_question_path(@answer.question)
      end
    end

    def destroy
      @answer = Answer.find_by(id: params[:id])
      operation = Operations::Answers::Destroy.new
      result = operation.call(@answer)

      case result
      in Success
        flash[:notice] = "Answer successfuly deleted"
        redirect_to terra_question_path(@answer.question)
      in Failure[error, payload]
        flash[:error] = "While destroy answer somethimg went wrog- #{error} : #{payload} "
        redirect_to terra_question_path(@answer.question)
      end
    end

    private

    def answer_params
      params.require(:answer).permit(:body, :question_id)
    end
    
  end
end