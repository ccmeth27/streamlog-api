class SessionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :user_name
end
