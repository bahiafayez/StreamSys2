module SessionsHelper

  def sign_in2(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def current_user=(user)  #method name: current_user= .. a setter
    @current_user = user
  end
  
  def current_user  #getter
    @current_user ||= user_from_remember_token 
    #sets current user to the user_from_remember_token only if
    #current user is undefined.. i.e. first time only.
  end
  
  def signed_in?
    !current_user.nil?  #calls the current user method
  end
  
  def current_user?(user)
    user == current_user
  end
  
  #def correct_user?
  #  params[:id] == current_user.id
  #end
  
  def authenticate
      deny_access unless signed_in?
  end
  
 # def authenticate2
  #     deny_access unless correct_user?
  #end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
    #equivalent to: 
    #flash[:notice] = "Please sign in to access this page."
    #redirect_to signin_path  
  end
  # The storage mechanism is the session facility provided by Rails, 
  # which you can think of as being like an instance of the cookies 
  # variable from Section 9.3.2 that automatically expires upon 
  # browser close.
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
      # * di 3ashan remember token is an array fa ana 3ayza ab3at el arguments separate..
      # as in User.authenticate_with_salt(id, salt)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end
  
end
