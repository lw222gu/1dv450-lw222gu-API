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
end
