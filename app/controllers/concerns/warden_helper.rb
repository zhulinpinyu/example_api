module WardenHelper
  extend ActiveSupport::Concern

  include do
    helper_method :warden, :current_user
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end
end