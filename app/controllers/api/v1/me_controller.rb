class Api::V1::MeController < Api::V1::ApiController
  before_action :me

  def show
    render json: @account, serializer: MeSerializer, status: :ok
  end

  # PUT/PATCH /me
  def update
    if @account.update(account_params)
      render json: '', status: :no_content
    else
      render json: { error: @account.errors.full_messages }, status: :not_acceptable
    end
  end

  # GET /me/following
  def following
    render json: @account.following_by_type('Account'), status: :ok
  end

  # GET /me/followers
  def followers
    render json: @account.followers_by_type('Account'), status: :ok
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
      localizationAttributes: %i[latitude longitude],
      addressAttributes: %i[street number complement neighborhood zipCode city state country]
    ).to_unsafe_h.to_snake_keys
  end
end
