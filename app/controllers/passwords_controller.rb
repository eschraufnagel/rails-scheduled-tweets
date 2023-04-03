class PasswordsController < ApplicationController
    before_action :require_user_logged_in!
    
    def edit

    end

    def update
        user = Current.user
        if Current.user
            @user = User.update(user_params)
            redirect_to root_path, notice: "Logged in successfully."
        else
            flash[:alert] = "Invalid email or password."
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end