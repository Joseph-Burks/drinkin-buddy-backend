class User < ApplicationRecord
    has_secure_password
    validates :username, {presence: true, uniqueness: true}
    validates :password, length: {in: 6..20}
    validates_inclusion_of :is_maker?, in: [true, false]
    validates :name,:address, presence: true, if: :is_maker?
end
