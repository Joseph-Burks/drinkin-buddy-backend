class Review < ApplicationRecord
    belongs_to :beer
    belongs_to :user
    validates :rating, {presence: true}
    validates :user, uniqueness: {scope: :beer, message: "You already reviewed this beer."}
end
