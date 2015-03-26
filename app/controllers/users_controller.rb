class UsersController < ApplicationController
    acts_as_token_authentication_handler_for User

    def show
        pattern = {id:true, user_email:true, user_token:true}

        if safe_params = valid_params(pattern, params)
            if user = valid_object(User, safe_params[:id])
                render json: user, :except =>[:authentication_token], status: 200, method: :get
            end
        end
    end
end
