module SessionsHelper

	def log_in(user)
		session[:user_id] = user.id
	end

	def current_user   #returns the current user logged in
		if (user_id = session[:user_id])
			 @current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id]) #checks if there are any cookies deposited
		 	user = User.find_by(id: user_id)			
		 	if user && user.authenticated?(cookies[:remember_token]) 		 	
		 		log_in(user)
		 		 @current_user = user
		 	end
		end
	end

	def logged_in?
		!current_user.nil?
	end

	def remember(user) #remembers a user in a persistent session
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end


	def log_out 
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil		
	end


	def forget(user) #deletes cookies
		user.forget     #updates user model's remember_digest as nil
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def current_user?(user) #confirms the correct user
		user == current_user
	end

  	def redirect_back_or(default)  # Redirects to stored location (or to the default).
    	redirect_to(session[:forwarding_url] || default)
    	session.delete(:forwarding_url)
  	end
 
  	def store_location # Stores the URL trying to be accessed.
    	session[:forwarding_url] = request.original_url if request.get? #only stores get requests
  	end
end
