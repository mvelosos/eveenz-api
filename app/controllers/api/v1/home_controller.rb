class Api::V1::HomeController < Api::V1::ApiController
  def cards
    result = Api::V1::Home::CardsContructorService.call(current_user, localization_params)
    render json: result, status: :ok
  end

  private

  def localization_params
    params.require(:localization).permit(
      :lat,
      :lon
    ).to_unsafe_h.to_snake_keys.symbolize_keys
  end
end
