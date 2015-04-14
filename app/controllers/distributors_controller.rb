class DistributorsController < ApplicationController
  acts_as_token_authentication_handler_for User

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
    pattern = {user_email:true, user_token:true, name:true, city:true, state:true, address:true, latitud:true, longitude:true, phone:false, email:false, website:false, schedule:false, picture_id:false}
    if safe_params = valid_params(pattern, params)
      if distributor = valid_request(Distributor.new, safe_params.except(:user_email, :user_token))
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

  # Update an distributor by excel documento
  # PUT /distributor/update_excel
  def update_excel
    pattern = {user_email:true, user_token:true, file: true}

    if safe_params = valid_params(pattern, params)
        # If excel file is already present
        if @excel_file = valid_object(ExcelFile, 1)
          if updated = valid_request(@excel_file, safe_params.except(:user_email, :user_token))
            file = Roo::Excel.new(@excel_file.file.path)
            render json: file.row(12)[0], status: 200, method: :put
            return
          end
        elsif excel_file = valid_request(ExcelFile.new, safe_params.except(:user_email, :user_token))
          #Do something
          return
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
            render json: {'delete' => distributor}, status: 200, method: :delete
        end
    end
  end
end
