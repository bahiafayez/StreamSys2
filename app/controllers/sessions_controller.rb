class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

    
  def create
    user = User.authenticate(params[:session][:username],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      # Sign the user in and redirect to the user's show page.
      sign_in2 user #Must write this sign_in function (in sessions helper)
      redirect_back_or user
    end
  end
 
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
