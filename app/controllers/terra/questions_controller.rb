module Terra
  class QuestionsController < BaseController

    def index
      @questions = Question.all
      @question = Question.new
    end

    def new
      @question = Question.new
    end

    def create
      operation = Operations::Questions::Create.new
      result = operation.call(question_params)

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
    end

    def update
    end

    def destroy
    end

    private
    def question_params
      params.require(:question).permit(:title, :body)
    end
  end
end