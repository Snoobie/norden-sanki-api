class DistributorsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Show all distributors
  # GET /distributor/all
  def index
      @distributors = Distributor.all
      render json: @distributors, status: 200, method: :get
  end

  # Get an distributor
  # GET /distributor?id=1
  def show
      pattern = {id: true}
      if safe_params = valid_params(pattern, params)
          if distributor = valid_object(Distributor, safe_params[:id])
              render json: distributor, status: 200, method: :get
          end
      end
  end

  # Create an distributor
  # POST /distributor/create
  def create
    pattern = {name:true, city:true, state:true, address:true, latitude:true, longitude:true, phone:false, email:false, website:false, schedule:false, picture_id:false}
    if safe_params = valid_params(pattern, params)
      if distributor = valid_request(Distributor.new, safe_params)
          render json: distributor, status: 201, method: :post
      end
    end
  end

  # Update an distributor
  # PUT /distributor/update
  def update
    pattern = {id: true, name:false, city:false, state:false, address:false, latitude:false, longitude:false, phone:false, email:false, website:false, schedule:false, picture_id:false}

    if safe_params = valid_params(pattern, params)
        if distributor = valid_object(Distributor, safe_params[:id])
            if updated = valid_request(distributor, safe_params.except(:id))
                render json: updated, status: 200, method: :put
            end
        end
    end
  end

  # Delete an distributor
  # DELETE /distributor/delete
  def delete
    pattern = {id: true}

    if safe_params = valid_params(pattern, params)
        if distributor = valid_object(Distributor, safe_params[:id])
            distributor.delete
            render json: {'delete' => distributor, 'file' => file}, status: 200, method: :delete
        end
    end
  end
end
