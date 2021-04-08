class Api::V1::MeController < Api::V1::ApiController
  before_action :me

  # GET /me
  def show
    render json: @account, serializer: MeSerializer, status: :ok
  end

  # PUT/PATCH /me
  def update
    @account.update(account_params)
    respond_with_object_or_message_status(@account, ApiSuccessSerializer, root: 'me')
  end

  # GET /me/events/mine
  def mine
    @events = Event.where(account: @account)
    render json: @events, each_serializer: EventSerializer, account: @account, status: :ok
  end

  # GET /me/events/confirmed
  def confirmed
    @events = Event.joins('INNER JOIN follows ON events.id = follows.followable_id')
                   .where('follows.followable_type = ?', Event)
                   .where('follows.follower_type = ?', Account)
                   .where('follows.follower_id = ?', @account)
    render json: @events, each_serializer: EventSerializer, account: @account, status: :ok
  end

  private

  def me
    @account = current_user.account
  end

  def account_params
    params.require(:account).permit(
      :name,
      :bio,
      :popularity,
      userAttributes: %i[email username],
      localizationAttributes: %i[latitude longitude],
      addressAttributes: %i[street number complement neighborhood zipCode city state country]
    ).to_unsafe_h.to_snake_keys
  end
end
