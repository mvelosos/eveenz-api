class Api::V1::RequestCategoriesController < Api::V1::ApiController
  def create
    formatted_params = request_category_params.merge(requested_by: @current_user.account)
    @request_category = RequestCategory.create(formatted_params)
    respond_with_object_or_message_status(@request_category, ApiSuccessSerializer)
  end

  private

  def request_category_params
    params.require(:requestCategory).permit(
      :name
    ).to_unsafe_h.to_snake_keys
  end
end
