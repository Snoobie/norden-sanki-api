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

    def delete
      pattern = {user_email:true, user_token:true}

      if safe_params = valid_params(pattern, params)
          if user = User.where(:email => safe_params[:user_email]).first
            user.delete
            render json: {'Success' => user}, status: 200, method: :delete
          else
            render json: {'Error' => 'Could not find the user'}, status: 400, method: :delete
          end
      end
    end

    def delete_user
      pattern = {id:true, user_email:true, user_token:true}

      if safe_params = valid_params(pattern, params)
        if user = User.where(:email => safe_params[:user_email]).first
        end
      end

    end
end
