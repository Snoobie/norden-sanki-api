class SessionsController < Devise::SessionsController

  def create
    # Fetch params
    email = params[:email] || params[:user][:email]
    password = params[:password] || params[:user][:password]

    id = User.find_by(email: email).try(:id) if email.presence

    if email.nil? or password.nil?
      render status: 400, json: { message: 'The request MUST contain the user email and password.' }
      return
    end

    # Authentication
    user = User.find_by(email: email)
    if user
      if user.valid_password? password
        user.restore_authentication_token!
        # Note that the data which should be returned depends heavily of the API client needs.
        render status: 200, json: { email: user.email, authentication_token: user.authentication_token, id: id, user: user}
      else
        render status: 401, json: { message: 'Invalid email or password.' }
      end
    else
      render status: 401, json: { message: 'Invalid email or password.' }
    end
  end

  def destroy
    # Fetch params
    user = User.find_by(authentication_token: params[:user_token])

    if user.nil?
      render status: 404, json: { message: 'Invalid token.' }
    else
      user.authentication_token = nil
      user.save!
      render status: 204, json: nil
    end
  end
end
