class ApplicationController < ActionController::API
  include WardenHelper
  before_action :authenticate!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :missing_param_error

  private
    def not_found
      render status: :not_found, json: ""
    end

    def missing_param_error(exception)
      render status: :unprocessable_entity, json: {error: exception.message}
    end
end
