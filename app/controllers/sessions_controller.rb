class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          session[:user_id] = user.id
          flash.now[:notice] = "Logged in successfully"
          redirect_to user
        else
          flash.now[:notice] = "There was something wrong with your login detail."
          render :new
        end
    end

    def destroy
          session[:user_id] = nil
          respond_to do |format|
            format.html { redirect_to root_path, notice: "logged out." }
            format.json { head :no_content }
          end
    end
end