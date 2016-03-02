class UnauthenticatedController < ActionController::Metal
  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    self.status = :unauthorized
    self.content_type = "application/json"
    self.response_body = {errors: ["Unauthorized Request"]}.to_json
    self.headers["Access-Control-Allow-Origin"]  = "*"
    self.headers["Access-Control-Allow-Methods"] = %w{GET POST PUT OPTIONS DELETE}.join(',')
    self.headers["Access-Control-Allow-Headers"] = %w{Content-Type Accept X-User-Email X-Auth-Token}.join(',')
  end
end