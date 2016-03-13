require 'jwt'

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

  def api_key
    key = Client.find_by(key: request.headers['X-ApiKey'])
    bad_request and return if key.nil?
    invalid_key unless key.active
    true
  end

  def bad_request
    render json: { status: 400, error: 'Bad request' }, status: :bad_request
  end

  def forbidden
    render json: { status: 403, error: 'Forbidden.' }, status: :forbidden
  end

  def invalid_key
    render json: { status: 401, error: 'Unauthorized. Api key is revoked.' }, status: :unauthorized
  end

  def unauthorized
    render json: { status: 401, error: 'Unauthorized.' }, status: :unauthorized
  end

  def not_found
    # TODO: Instead of formatting json here, call a method that can handle
    # several error messages at once.
    render json: { status: 404, error: 'Not found' }, status: :not_found
  end

  def not_acceptable
    # TODO: check if status code is correct
    render json: { status: 406, error: 'Not acceptable.' }, status: :not_acceptable
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

  def resource_owner_authentication(instance)
    @current_user == instance.resource_owner_id
  end

  # JWT Authentication

  def api_authenticate
    if request.headers['Authorization'].present?
      header = request.headers['Authorization']
      header.split(' ').last
      @token_payload = decode_JWT header.strip
      unless @token_payload
        bad_request
      end
      @current_user = @token_payload[0]['user_id']
    else
      forbidden
    end
  end

  def decode_JWT(token)
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base, 'HS512')
    if payload[0]['exp'] >= Time.now.to_i
      payload
    else
      false
    end
  rescue
    nil
  end

  def encode_JWT(resource_owner, expires = 1.hours.from_now)
    payload = { user_id: resource_owner.id, exp: expires.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS512')
  end
end
