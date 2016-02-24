class Api::V1::TagsController < Api::V1::BaseController
  def index
    tags = Tag.all
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
    render(json: Api::V1::TagSerializer.new(tag).to_json)
  end

  def create
    tag = Tag.new(create_params)
    # TODO: add functionality for returning an error if salary is not valid.
    tag.save! # TODO: If not valid, ActiveRecord::recordInvalid. Add rescue.
    render(
      json: tag,
      status: 201,
      location: api_v1_tag_path(tag.id),
      serializer: Api::V1::TagSerializer
    )
  end

  def destroy
  end

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
