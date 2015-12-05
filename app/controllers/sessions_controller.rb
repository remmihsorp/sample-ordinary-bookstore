class SessionsController < ApplicationController

  def new
  end

  def create     
    user = User.find_by(login_id: params[:session][:login].downcase) # need to change to db query
    authenticate = verify_user_password(user, params) 
    if user && authenticate
      log_in user
      render 'new'
    else 
      flash.now[:danger] = "Invalid login/password combination"
      render 'new'
    end
  end

  def destroy
    log_out
    render 'new'
  end

end