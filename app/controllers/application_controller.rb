class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user#, :require_login

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

  protected
  # def require_login
  #   # if session[:user_id]
  #   #   @login_user = User.find_by(id: session[:user_id])
  #   # end
  #   @user = User.find_by(id: session[:user_id])
  #   unless @user
  #     flash[:status] = :failure
  #     flash[:message] = "You must be logged in to do that!"
  #     redirect_to root_path
  #   end
  # end


  def save_and_flash(model)
    result = model.save

    if result
      flash[:status] = :success
      flash[:result_text] = "Successfully saved #{model.class} #{model.id}"
    else
      flash.now[:status] = :failure
      flash.now[:result_text] = "Failed to save #{model.class}"
      flash.now[:details] = model.errors.result_text
    end

    return result
  end






  private
  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end



end# class
