class Api::V1::ProfileController < Api::V1::ApiController
  before_action :profile

  # GET /profile
  def show
    render json: @account, serializer: ProfileSerializer, status: :ok
  end

  # PUT/PATCH /profile
  def update
    @account.update(account_params)
    respond_with_object_or_message_status(@account, ApiSuccessSerializer, root: 'profile')
  end

  # GET /profile/events/mine
  def mine
    @events = Event.where(account: @account)
    api_list_render(@events.with_attached_images, each_serializer: EventSerializer)
  end

  # GET /profile/events/confirmed
  def confirmed
    @events = Event.joins('INNER JOIN follows ON events.id = follows.followable_id')
                   .where('follows.followable_type = ?', Event)
                   .where('follows.follower_type = ?', Account)
                   .where('follows.follower_id = ?', @account)
    api_list_render(@events, each_serializer: EventSerializer)
  end

  private

  def profile
    @account = current_user.account
  end

  def account_params
    params.require(:account).permit(
      :name,
      :bio,
      :popularity,
      avatar: %i[data filename],
      accountSettingAttributes: %i[private],
      userAttributes: %i[email username],
      localizationAttributes: %i[latitude longitude],
      addressAttributes: %i[street number complement neighborhood zipCode city state country]
    ).to_unsafe_h.to_snake_keys
  end
end
