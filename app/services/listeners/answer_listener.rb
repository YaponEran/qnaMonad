# module Listeners
#   class AnswerListener
#     def question_answer_created(payload)
#       create_question_answer(payload)
#     end

#     private

#     def create_question_answer(payload)
#       question_answer = Answer.create!(
#         user_id: payload[:user_id],
#         question_id: payload[:question_id],
#         body: payload[:body]
#       )

#       return if question_answer

#       logger
#         .tagged("LISTENER")
#         .error("Question answer went wrong")
#     end
#   end
# end