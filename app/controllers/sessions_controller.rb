class SessionsController < ApplicationController
  # def login_form
  # end

  #esta linea la puse yo
  skip_before_action :require_login, only: [:login, :logout]

  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(provider: params[:provider], uid: auth_hash['uid'])
      if user.nil?
        #User has not logged in before
        # Create a new record in the DB
        user = User.from_auth_hash(params[:provider], auth_hash)
        save_and_flash(user)


      else
        flash[:status] = :success
        flash[:result_text] = "Successfully logged in as returning user #{user.username}"

      end

      # Log the user in
      session[:user_id] = user.id
      # raise
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create user from OAuth data"
    end

    redirect_to root_path

  end


    # username = params[:username]
    # if username and user = User.find_by(username: username)
    #   session[:user_id] = user.id
    #   flash[:status] = :success
    #   flash[:result_text] = "Successfully logged in as existing user #{user.username}"
    # else
    #   user = User.new(username: username)
    #   if user.save
    #     session[:user_id] = user.id
    #     flash[:status] = :success
    #     flash[:result_text] = "Successfully created new user #{user.username} with ID #{user.id}"
    #   else
    #     flash.now[:status] = :failure
    #     flash.now[:result_text] = "Could not log in"
    #     flash.now[:messages] = user.errors.messages
    #     render "login_form", status: :bad_request
    #     return
    #   end
    # end
    # redirect_to root_path


  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
