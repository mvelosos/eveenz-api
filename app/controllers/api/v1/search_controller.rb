class Api::V1::SearchController < Api::V1::ApiController
  # GET /search?query=
  def index
    result = Api::V1::Search::SearchService.call(current_user.account, params)
    render json: result, status: :ok
  end
end
