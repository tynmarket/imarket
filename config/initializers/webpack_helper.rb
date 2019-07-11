# https://medium.com/studist-dev/goodbye-webpacker-183155a942f6

ActiveSupport.on_load :action_controller do
  ActionController::Base.helper WebpackHelper
end

ActiveSupport.on_load :action_view do
  include WebpackHelper
end

if Rails.env.development?
  require 'rack/proxy'

  # webpack-dev-serverからのアセット取得をプロキシする -> localhost以外からもdev環境を見れるようにするため
  class DevServerProxy < Rack::Proxy
    def perform_request(env)
      if env['PATH_INFO'].start_with?('/packs/')
        env['HTTP_HOST'] = dev_server_host
        env['HTTP_X_FORWARDED_HOST'] = dev_server_host
        env['HTTP_X_FORWARDED_SERVER'] = dev_server_host
        super
      else
        @app.call(env)
      end
    end

    private

      def dev_server_host
        Rails.application.config.dev_server_host
      end
  end

  Rails.application.config.middleware.use DevServerProxy, ssl_verify_none: true
end
