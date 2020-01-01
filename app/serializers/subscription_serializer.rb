class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :amazon, :disney, :fx, :hbo, :hulu, :netflix, :showtime, :starz, :tbs, :tnt, :usa
end
