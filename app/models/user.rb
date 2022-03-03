class User < ApplicationRecord
    has_secure_password
    has_many :breweries
    has_many :reviews
    has_many :beers, through: :reviews
    
    validates :username, {presence: true, uniqueness: true}
    validates :password, length: {in: 6..20}
    validates_inclusion_of :is_maker?, in: [true, false]
end
