class SessionsController < ApplicationController
	def new
	end

	def create
		#try to authenticate the user - if they authenticate successfully, an instance of the User model is returned
		@user = User.authenticate(params[:email], params[:password])
		#if an instance is returend and @user is not nil...
		if @user
			flash[:notice] = "You've been logged in."
			#let the user know they've been logged in with a flash message
			session[:user_id] = @user.id
			#THIS IS THE MOST IMPORTANT PART. Actually log the user in by storing their ID in the session with the [:user.id] key!
			redirect_to "/"
		else
			#whoops, either the user wasn't in the database or their password is incorrect, so let them know, then redirect them to the log in page
			flash[:alert] = "There was a problem loggin you in."
			redirect_to log_in_path
		end	
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You've been logged out successfully."
		redirect_to "/"
	end
end
