module Terra
  class QuestionsController < BaseController
    before_action :authenticate_user!
    
    def index
      @questions = Question.all
      @question = Question.new
    end

    def new
      @question = Question.new
    end

    def create
      operation = Operations::Questions::Create.new
      result = operation.call(question_params, current_user)

      case result
      in Success
        @question = Question.last
        flash[:notice] = "Question successfully created"
        render "create.js.erb", layout: false
      in Failure[error, payload]
        @error = error
        @payload = payload
        render "error.js.erb", layout: false
      end
    end

    def show
      @question = Question.find(params[:id])
      @answer = Answer.new
    end

    def edit
      @question = Question.find(params[:id])
    end

    def update
      @question = Question.find(params[:id])

      operation = Operations::Questions::Update.new
      result = operation.call(@question, question_params)

      case result
      in Success
        flash[:notice] = "Question successfully updated"
        redirect_to terra_questions_path
      in Failure[error, payload]
        flash[:error] = "Something went wrong"
        redirect_to terra_questions_path
      end
    end

    def destroy
      @question = Question.find(params[:id])

      operation = Operations::Questions::Destroy.new
      result = operation.call(@question)

      case result
      in Success
        flash[:notice] = "Question successesfully deleted!"
        redirect_to terra_questions_path
      in Failure[error, payload]
        flash[:notice] = "Question successesfully deleted!"
        redirect_to terra_questions_path
      end
    end

    def vote_up
      @question = Question.find(params[:id])
      operation = Operations::Votes::VoteUp.new
      result = operation.call(@question, current_user)

      case result
      in Success
        flash[:notice] = "Question vote successfully votes"
        redirect_to terra_question_path
      in Failure[error, payload]
        flash[:error] = "While vote went something wrong: #{error} - #{payload}"
        redirect_to terra_question_path
      end
    end

    def vote_down
      @question = Question.find(params[:id])
      operation = Operations::Votes::VoteDown.new
      result = operation.call(@question, current_user)

      case result
      in Success
        flash[:notice] = "Successfuly unvoted"
        redirect_to terra_question_path
      in Failure[error, payload]
        flash[:error] = "While unvoting went wrong: #{error} - #{payload}"
        redirect_to terra_question_path
      end
    end

    private
    def question_params
      params.require(:question).permit(:title, :body)
    end
  end
end