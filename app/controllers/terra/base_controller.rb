# frozen_string_literal: true

module Terra
  class BaseController < ApplicationController

    include Dry::Monads::Result::Mixin
    layout 'terra'
  end
end
