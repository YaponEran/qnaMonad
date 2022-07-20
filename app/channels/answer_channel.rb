# class AnswerChannel < ApplicationCable::Channel
#   def subscribed
#     resource = "question_answers_#{params[:id]}"
#     puts '!!!!!!!!'
#     puts resource
#     puts '!!!!!!!!'
#     stream_for resource
#   end

#   def unsubscribed
#     # Any cleanup needed when channel is unsubscribed
#     stop_all_streams
#   end
# end