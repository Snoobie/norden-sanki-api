class ChallengesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Show all challenges
  # GET /challenge/all
  def index
      @challenges = Challenge.all
      render json: @challenges, status: 200, method: :get
  end

  # Get an challenge
  # GET /challenge?id=1
  def show
      pattern = {id: true}
      if safe_params = valid_params(pattern, params)
          if challenge = valid_object(Challenge, safe_params[:id])
              render json: challenge, status: 200, method: :get
          end
      end
  end

  # Create an challenge
  # POST /challenge/create
  def create
    pattern = {name:true, start_date:true, end_date:true, limit_date:true, award_id:false, picture_id:false, product_id:false, description:false}
    if safe_params = valid_params(pattern, params)
      if challenge = valid_request(Challenge.new, safe_params)
          render json: challenge, status: 201, method: :post
      end
    end
  end

  # Update an challenge
  # PUT /challenge/update
  def update
    pattern = {id: true, name:false, start_date:false, end_date:false, limit_date:false, award_id:false, picture_id:false, product_id:false, description:false}

    if safe_params = valid_params(pattern, params)
        if challenge = valid_object(Challenge, safe_params[:id])
            if updated = valid_request(challenge, safe_params.except(:id))
                render json: updated, status: 200, method: :put
            end
        end
    end
  end

  # Delete an challenge
  # DELETE /challenge/delete
  def delete
    pattern = {id: true}

    if safe_params = valid_params(pattern, params)
        if challenge = valid_object(Challenge, safe_params[:id])
            challenge.delete
            render json: {'delete' => challenge, 'file' => file}, status: 200, method: :delete
        end
    end
  end
end
