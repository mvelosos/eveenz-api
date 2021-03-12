class Api::V1::CategoriesController < Api::V1::ApiController
  def index
    api_list_render(Category.kept, each_serializer: CategorySerializer)
  end
end
