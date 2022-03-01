class User < ApplicationRecord
    has_secure_password
    validates :username, {presence: true, uniqueness: true}
    validates :password, length: {in: 6..20}
    validates :is_maker?, {presence: true}
    validates :name,:address, presence: true, if: :is_maker?
end
