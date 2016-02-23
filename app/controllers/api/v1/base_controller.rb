class Api::V1::BaseController < ApplicationController
  # Disable sessions, since API on HTTP are stateless.
  before_action :destroy_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found!
    render json: { status: 404, errors: 'Not found' }.to_json
  end
end
