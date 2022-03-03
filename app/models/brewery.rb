class Brewery < ApplicationRecord
    belongs_to :user
    has_many :beers
end
