# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout "terra"

    def after_update_path_for(_resource)
      terra_root_path
    end
  end
end
  