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
end
