class Api::V1::TagsController < Api::V1::BaseController
  before_action :offset_params, only: [:index]
  # Controls that the api key is valid.
  before_action :api_key

  def index
    tags = Tag.limit(@limit).offset(@offset)
    render(
      json: ActiveModel::ArraySerializer.new(
        tags,
        each_serializer: Api::V1::TagSerializer,
        root: 'tags' # root name in response json
      )
    )
  end

  def show
    tag = Tag.find(params[:id])
    render(
      json: Api::V1::TagSerializer.new(
        tag
      )
    )
  end

  def create
    tag = Tag.new(create_params)
    # If not valid, ActiveRecord::recordInvalid rescue in BaseController
    tag.save!
    render(
      json: tag,
      status: 201,
      location: api_v1_tag_path(tag.id),
      serializer: Api::V1::TagSerializer
    )
  end

  # No actions for update and delete,
  # since that would affect many users and not only one

  private

  def create_params
    parameters = ActionController::Parameters.new(
      tag:
      {
        tag: params[:tag]
      }
    )
    parameters.require(:tag).permit(:tag)
  end
end
