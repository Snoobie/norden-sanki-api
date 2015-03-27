class BlogsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Show all blogs
  # GET /blog/all
  def index
      @blogs = Blog.all
      render json: @blogs, status: 200, method: :get
  end

  # Get an blog
  # GET /blog?id=1
  def show
      pattern = {id: true}
      if safe_params = valid_params(pattern, params)
          if blog = valid_object(Blog, safe_params[:id])
              render json: blog, status: 200, method: :get
          end
      end
  end

  # Create an blog
  # POST /blog/create
  def create
    pattern = {title:true, author:true, picture_id:false, video_id:false, description: true}
    if safe_params = valid_params(pattern, params)
      if blog = valid_request(Blog.new, safe_params)
          render json: blog, status: 201, method: :post
      end
    end
  end

  # Update an blog
  # PUT /blog/update
  def update
    pattern = {id: true, title:false, author:false, picture_id:false, video_id:false, description: false}

    if safe_params = valid_params(pattern, params)
        if blog = valid_object(Blog, safe_params[:id])
            if updated = valid_request(blog, safe_params.except(:id))
                render json: updated, status: 200, method: :put
            end
        end
    end
  end

  # Delete an blog
  # DELETE /blog/delete
  def delete
    pattern = {id: true}

    if safe_params = valid_params(pattern, params)
        if blog = valid_object(Blog, safe_params[:id])
            blog.delete
            render json: {'delete' => blog, 'file' => file}, status: 200, method: :delete
        end
    end
  end
end
