class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # authenticate the user
    @user = User.find_by({"email" => params["email"]})
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] =@user["id"]
        redirect_to "/companies"
        flash["notice"] = "Welcome, #{@user["first_name"]}!"
      else    
        flash["notice"] = "Nope."
        redirect_to "/sessions/new" 
      end
    else
      flash["notice"] = "Nope."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    # logout the user
    session["user_id"] = nil # we have to end the cookies
    flash["notice"] = "Goodbye."
    redirect_to "/sessions/new"
  end
end
