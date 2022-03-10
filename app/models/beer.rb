class Beer < ApplicationRecord
    belongs_to :brewery
    belongs_to :style
    has_many :reviews
    has_many :users, through: :reviews
    validates :name, {presence: true, uniqueness: true}
end
