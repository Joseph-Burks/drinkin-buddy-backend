class Brewery < ApplicationRecord
    has_many :beers
    has_many :reviews, through: :beers
    has_many :users, through: :reviews
    validates :name, {presence: true, uniqueness: {message: 'Name already exists.'}}
end
