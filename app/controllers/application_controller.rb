class ApplicationController < ActionController::API
    before_action :logged_in?

    def current_user
        begin
            method, token = request.headers[:Authorization].split(' ')
            puts token
            if method === 'Bearer'
                payload, header = JWT.decode(token, ENV["JWT_KEY"])
                return User.find(payload['user_id'])
            end
        rescue
            raise Exception.new('You must be logged in to make this request.')
        end
    end

    def logged_in?
        !!current_user
    end

    def delete_interest(beer_id)
        user = current_user
        interest = Interest.find_by(user_id: user.id, beer_id: beer_id.to_i)
        if interest
            interest.destroy
        end
    end
end
