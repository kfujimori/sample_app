class UsersController < ApplicationController
    def index
        @users = User.all
    end
    def show
        @user = User.find(params[:id])
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_param)
        if @user.save
            flash[:success] = "Welcome to the Sample App!"
            redirect_to @user
        else
            render 'new'
        end
    end
    # def signup
    # end

    private

    def user_param
        params.require(:user).permit(:name,
                                        :email,
                                        :password,
                                        :password_confirmation
        )
    end


end
