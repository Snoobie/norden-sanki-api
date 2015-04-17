class RegistrationsController < Devise::RegistrationsController
    #skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
    #skip_before_filter :authenticate_scope!, :only => [:update]
    respond_to :json

    def create
      user = User.new(:email => params[:email], :password => params[:password])
      if user.save
        render :json=> user, :status=>201
        return
      else
        warden.custom_failure!
        render :json=> user.errors, :status=>400
      end
    end

    def resend_confirmation
      pattern = {user_email:true}

      if safe_params = valid_params(pattern, params)
          if user = User.where(:email => safe_params[:user_email]).first
            response = user.resend_confirmation_instructions
            if response
              render json: {'success' => 'Confirmation email resend with a new token'}, status: 201, method: :get
            else
              render json: {'error' => 'Confirmation email could not be send'}, status: 400, method: :get
            end
          end
      end
    end
end
