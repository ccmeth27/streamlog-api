class User < ApplicationRecord
    has_secure_password
    has_one :subscriptions
    has_many :user_programs
    validates :username, presence: true
    validates :username, uniqueness: true
    validates :username, length: { minimum: 3 }
end
