module Warden
  module Test
    module ControllerHelpers
      def self.included(base)
        base.class_eval do
          setup :setup_controller_for_warden, :warden if respond_to?(:setup)
        end
      end

      def process(*)
        _catch_warden {super} || @response
      end

      def setup_controller_for_warden
        @request.env['action_controller.instance'] = @contrller
      end

      def warden
        @warden ||= begin
          manager = Warden::Manager.new(nil, &Rails.application.config.middleware.detect{|m| m.name == 'Warden::Manager'}.block)
          @request.env['warden'] = Warden::Proxy.new(@request.env, manager)
        end
      end

      protected

      def _catch_warden(&block)
        result = catch(:warden, &block)
        if result.is_a?(Hash) && !warden.custom_failure? && !@controller.send(:performed?)
          result[:action] ||= :unauthenticated
          env = @controller.request.env
          env['PATH_INFO'] = "/#{result[:action]}"
          env['warden.options'] = result
          Warden::Manager._run_callbacks(:before_failure, env, result)
          status, headers, body = warden.config[:failure_app].call(env).to_a
          @controller.send :render, status: status, text: body,
            content_type: headers['Content-Type'], location: headers['Location']

          nil
        else
          result
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include Warden::Test::ControllerHelpers, type: :controller
end