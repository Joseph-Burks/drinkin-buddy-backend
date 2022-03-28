class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :beers, through: :reviews
    has_many :breweries, through: :beers
    has_many :interests
    has_many :interested_beers, through: :interests, source: :beer

    
    validates :username, {presence: true, uniqueness: true}
    validates :password, length: {in: 6..20}
end
