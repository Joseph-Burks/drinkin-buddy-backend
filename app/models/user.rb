class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :beers, through: :reviews
    has_many :breweries, through: :beers
    has_many :interests
    has_many :interested_beers, through: :interests, source: :beer

    
    validates :username, {presence: true, uniqueness: true}
    validates :password, length: {in: 6..20}

    def get_reviews_with_beer
        revs = []
        self.reviews.each do |review|
            rev = {
                id: review.id,
                rating: review.rating,
                note: review.note,
                beer: review.beer,
                created: review.created_at
            }
            revs.push(rev)
        end
        revs
    end
end
