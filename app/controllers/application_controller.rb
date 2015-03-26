class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :clean_params

  def clean_params
    params.except!(:controller, :action)
  end

  def valid_params pattern, params
    errors = Hash.new

    pattern.each do |k, v|
      if v and params.has_key?(k.to_s) == false
        errors = errors.merge({k => 'missing required parameter'})
      end
    end
    params.keys.each do |k|
      unless pattern.has_key? k.to_sym
        errors = errors.merge({k => 'unknown parameter'})
      end
    end
    unless errors.empty?
      render :json => {:code => 101, :type => 'wrong_parameters', :parameters => errors}, :status => 400, :method => :get
      return false
    end
    return params.permit(pattern.keys)
  end

  ## Check if params[:id] corresponds to a valid record
  def valid_object model, id
    unless object = model.find_by_id(id)
      errors = {:id => 'no corresponding entry'}
      render :json => {:code => 101, :type => 'wrong_parameters', :parameters => errors}, :status => 400, :method => :get
      return false
    end
    return object
  end

  ## Check if other params passed model validations
  def valid_request object, params
    object.attributes = params
    unless object.valid?
      errors = Hash.new
      object.errors.messages.each do |k, v|
        errors = errors.merge({k => v[0]})
      end
      render :json => {:code => 102, :type => 'invalid_parameters', :parameters => errors}, :status => 400, :method => :get
      return false
    end
    object.save
    return object
  end
end
