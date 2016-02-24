class Api::V1::BaseController < ApplicationController
  before_action :destroy_session
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found!
  rescue_from ActiveRecord::RecordInvalid, with: :invalid!

  # Disable sessions, since API on HTTP are stateless.
  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found!
    # TODO: Instead of formatting json here, call a method that can handle
    # several error messages at once.
    render json: { status: 404, errors: 'Not found' }.to_json
  end

  def invalid!
    render json: { status: 422, errors: 'Invalid' }.to_json
  end
end
