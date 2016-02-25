class Api::V1::BaseController < ApplicationController
  before_action :destroy_session
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :not_acceptable

  # Disable sessions, since API on HTTP are stateless.
  def destroy_session
    request.session_options[:skip] = true
  end

  OFFSET = 0
  LIMIT = 20

  def offset_params
    @offset = convert_to_integer(params[:offset]) if params[:offset].present?
    @limit = convert_to_integer(params[:limit]) if params[:limit].present?
    @offset ||= OFFSET
    @limit ||= LIMIT
  end

  def not_found
    # TODO: Instead of formatting json here, call a method that can handle
    # several error messages at once.
    render json: { status: 404, error: 'Not found' }.to_json
  end

  def not_acceptable
    # TODO: check if status code is correct
    render json: { status: 406, error: 'Not acceptable.' }.to_json
  end

  def removed
    render json: { status: 200, message: 'The post has been removed.' }
  end

  def convert_to_integer(string)
    Integer(string || '')
  rescue ArgumentError
    # If string can not be converted to an integer, or string is '', return nil
    nil
  end

  def convert_to_decimal(string)
    Float(string || '')
  rescue ArgumentError
    # If string can not be converted to a float, or string is '', return nil
    nil
  end
end
