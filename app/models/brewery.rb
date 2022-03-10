class Brewery < ApplicationRecord
    has_many :beers
    has_many :styles, through: :reviews
    has_many :reviews, through: :beers
    has_many :users, through: :reviews
    validates :name, {presence: true, uniqueness: true}
end
