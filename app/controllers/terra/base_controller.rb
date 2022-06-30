# frozen_string_literal: true

module Terra
  class BaseController < ApplicationController
    before_action :authenticate_user!

    include Dry::Monads::Result::Mixin
    layout 'terra'
  end
end
