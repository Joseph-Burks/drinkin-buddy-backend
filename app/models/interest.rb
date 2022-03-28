class Interest < ApplicationRecord
    belongs_to :user
    belongs_to :beer

    validates :user, uniqueness: {scope: :beer}
end
