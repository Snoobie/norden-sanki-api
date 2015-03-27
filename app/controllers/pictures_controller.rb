class PicturesController < ApplicationController
  respond_to :json
  require 'fileutils'

  # Show all pictures
  # GET /picture/all
  def index
      @pictures = Picture.all
      render json: @pictures, status: 200, method: :get
  end

  # Get a sport
  # GET /picture?id=1
  def show
      pattern = {id: true}
      if safe_params = valid_params(pattern, params)
          if picture = valid_object(Picture, safe_params[:id])
              render json: picture, status: 200, method: :get
          end
      end
  end


  # Create a picture
  # POST /picture/create
  def create
    pattern = {attachment:true, name:true, user_id:true, description: false}
    if safe_params = valid_params(pattern, params)
      picture = Picture.new(:attachment => params[:attachment], :name => params[:name], :user_id => params[:user_id], :description => params[:description])
      if picture.save
        render :json=> picture, :status=>201
        return
      else
        warden.custom_failure!
        render :json=> picture.errors, :status=>400
      end
    end
  end

  # Update a sport
  # PUT /sport/update
  def update
    pattern = {id: true, name: false, description: false}

    if safe_params = valid_params(pattern, params)
        if picture = valid_object(Picture, safe_params[:id])
            if updated = valid_request(picture, safe_params.except(:id))
                render json: updated, status: 200, method: :put
            end
        end
    end
  end

  # Delete a picture
  # DELETE /picture/delete
  def delete
    pattern = {id: true}

    if safe_params = valid_params(pattern, params)
        if picture = valid_object(Picture, safe_params[:id])
            picture.destroy
            file = FileUtils.rm_rf("#{Rails.root}/public/uploads/picture/attachment/" + params[:id] + '/')
            render json: {'delete' => picture, 'file' => file}, status: 200, method: :delete
        end
    end
  end
end
