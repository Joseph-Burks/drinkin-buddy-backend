class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :beers, through: :reviews
    
    validates :username, {presence: true, uniqueness: true}
    validates :password, length: {in: 6..20}
end
