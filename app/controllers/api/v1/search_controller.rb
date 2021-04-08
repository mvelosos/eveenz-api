class Api::V1::SearchController < Api::V1::ApiController
  # GET /search?query=
  def index
    search_result = Api::V1::Search::SearchService.call(current_user.account, params)
    render json: search_result, status: :ok
  end
end
