class UserProgram < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :imdb_id, scope: :user

end
