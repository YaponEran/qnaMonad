module Terra
  class AnswersController < BaseController
    before_action :authenticate_user!

    def new
      @answer = Answer.new
    end

    def create
      @question = Question.find(params[:question_id])

      operation = Operations::Answers::Create.new
      result = operation.call(answer_params.merge(question_id: @question.id), current_user)

      case result
      in Success
        @answer = @question.answers.last
        render "create.js.erb", layout: false
      in Failure[error, payload]
        flash[:error] = "Some thing went wrong: #{payload}"
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

    def choose_best
      @answer = Answer.find_by(id: params[:id])

      operation = Operations::Answers::BestAnswer.new
      result = operation.call(@answer)
      
      case result
      in Success
        flash[:notice] = "Answer best successfuly updated"
        redirect_to terra_question_path(@answer.question)
      in Failure[error, payload]
        flash[:error] = "While update best answer wen wrong - #{error} : #{payload}"
        redirect_to terra_question_path(@answer.question)
      end
    end

    def vote_up
      @answer = Answer.find_by(id: params[:id])
      operation = Operations::Votes::VoteUp.new
      result = operation.call(@answer, current_user)

      case result
      in Success
        flash[:notice] = "Answer vote successfuly created"
        redirect_to terra_question_path(@answer.question)
      in Failure[error, payload]
        flash[:error] = "While vote up answer went wrong with - #{error} : #{payload}"
        redirect_to terra_question_path(@answer.question)
      end
    end

    def vote_down
      @answer = Answer.find_by(id: params[:id])
      operation = Operations::Votes::VoteDown.new
      result = operation.call(@answer, current_user)

      case result
      in Success
        flash[:notice] = "Answer vote down successfuly updated"
        redirect_to terra_question_path(@answer.question)
      in Failure[error, payload]
        flash[:error] = "While vote down answer went wrong with - #{error} : #{payload}"
        redirect_to terra_question_path(@answer.question)
      end
    end

    private

    def answer_params
      params.require(:answer).permit(:body, :question_id)
    end
    
  end
end