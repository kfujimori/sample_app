class SessionsController < ApplicationController

    def new
    end

    def create
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)

        # request data exists and authentication succeeds
        if user && user.authenticate(params[:session][:password])
            # success
            sign_in user
            # redirect to stored-location page if exists
            redirect_back_or user
        else
            # fail. "now" enables to flash messages only once
            flash.now[:error] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def destroy
        sign_out
        redirect_to root_url
    end

end
