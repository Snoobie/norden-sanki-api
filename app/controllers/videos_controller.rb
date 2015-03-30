class VideosController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
  require 'fileutils'

  # Show all videos
  # GET /video/all
  def index
      @videos = Video.all
      render json: @videos, status: 200, method: :get
  end

  # Get a video
  # GET /video?id=1
  def show
      pattern = {id: true}
      if safe_params = valid_params(pattern, params)
          if video = valid_object(Video, safe_params[:id])
              render json: video, status: 200, method: :get
          end
      end
  end


  # Create a video
  # POST /video/create
  def create
    pattern = {attachment: true, name: true, user_id: true, description: false}
    if safe_params = valid_params(pattern, params)
      video = Video.new(:attachment => params[:attachment], :name => params[:name], :user_id => params[:user_id], :description => params[:description])
      if video.save
        render :json=> video, :status=>201
        return
      else
        warden.custom_failure!
        render :json=> video.errors, :status=>400
      end
    end
  end

  # Update a sport
  # PUT /sport/update
  def update
    pattern = {id: true, name: false, description: false, user_id: false, attachment: false}

    if safe_params = valid_params(pattern, params)
        if video = valid_object(Video, safe_params[:id])
            if updated = valid_request(video, safe_params.except(:id))
                render json: updated, status: 200, method: :put
            end
        end
    end
  end

  # Delete a video
  # DELETE /video/delete
  def delete
    pattern = {id: true}

    if safe_params = valid_params(pattern, params)
        if video = valid_object(Video, safe_params[:id])
            video.destroy
            file = FileUtils.rm_rf("#{Rails.root}/public/uploads/video/attachment/" + params[:id] + '/')
            render json: {'delete' => video, 'file' => file}, status: 200, method: :delete
        end
    end
  end
end
