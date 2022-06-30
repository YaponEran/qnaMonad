# frozen_string_literal: true
module Terra
  class WelcomeController < BaseController
    def index
      @main_content = {
        greeting: 'Welcome to the QNA app',
        start: 'Start page',
        img: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1772&q=80'
      }
    end
  end
end
