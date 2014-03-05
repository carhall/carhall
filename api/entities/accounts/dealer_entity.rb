module Accounts
  class DealerEntity < Accounts::AccountEntity
    with_options if: { type: :detail } do
      expose :area_id, :area, :dealer_type_id, :dealer_type, :business_scope_ids, :business_scopes,
        :company, :address, :phone, :open_during, :rqrcode_token
      expose :rqrcode_image, format_with: :image
      expose :latitude, :longitude
    end
    with_options if: { detail_type: :statistic } do
      expose :stars, :rank_id, :rank, :orders_count, 
        :mending_goal_attainment, :cleaning_goal_attainment, 
        :bulk_purchasing_goal_attainment, :vip_card_goal_attainment
    end
  end
end
