class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :reviews
    has_many :users, through: :reviews
    validates :name, {presence: true, uniqueness: {scope: :brewery_id, message: "with this name already exists."}}
end
