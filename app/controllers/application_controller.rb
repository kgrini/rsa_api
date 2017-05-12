class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected

  def render_response(body, status_code=200)
    render status: status_code, json: body.to_json
  end
end
