class Interest < ApplicationRecord
    validates :user, uniqueness: {scope: :beer}
end
