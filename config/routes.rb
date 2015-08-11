Rails.application.routes.draw do

  devise_for :admins
  root to: "home#index"

  use_doorkeeper
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      match "organizations/:group_organization_ids", to: "public_interface#feed_organization", via: :get
      match "organizations/:group_organization_ids", to: "private_interface#feed_organization", via: :get
      match "locations/:group_organization_id", to: "public_interface#feed_location", via: :get
      match "locations/:group_organization_id", to: "private_interface#feed_location", via: :get
      match "model_type_prices/:group_organization_id", to: "public_interface#feed_model_price", via: :post
    end
  end

end
