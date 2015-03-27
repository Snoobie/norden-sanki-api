class AwardsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Show all awards
  # GET /award/all
  def index
      @awards = Award.all
      render json: @awards, status: 200, method: :get
  end

  # Get an award
  # GET /award?id=1
  def show
      pattern = {id: true}
      if safe_params = valid_params(pattern, params)
          if award = valid_object(Award, safe_params[:id])
              render json: award, status: 200, method: :get
          end
      end
  end

  # Create an award
  # POST /award/create
  def create
    pattern = {name:true, picture_id:true, user_id:true, description: false}
    if safe_params = valid_params(pattern, params)
      if award = valid_request(Award.new, safe_params)
          render json: award, status: 201, method: :post
      end
    end
  end

  # Update an award
  # PUT /award/update
  def update
    pattern = {id: true, user_id:false, picture_id:false, name: false, description: false}

    if safe_params = valid_params(pattern, params)
        if award = valid_object(Award, safe_params[:id])
            if updated = valid_request(award, safe_params.except(:id))
                render json: updated, status: 200, method: :put
            end
        end
    end
  end

  # Delete an award
  # DELETE /award/delete
  def delete
    pattern = {id: true}

    if safe_params = valid_params(pattern, params)
        if award = valid_object(Award, safe_params[:id])
            award.delete
            render json: {'delete' => award, 'file' => file}, status: 200, method: :delete
        end
    end
  end
end
