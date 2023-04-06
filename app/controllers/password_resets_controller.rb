class PasswordResetsController < ApplicationController
    
    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user.present?
            # send email
            PasswordMailer.with(user: @user).reset.deliver_later
        else
        end

        redirect_to root_path, notice: "If an account exists with this email address, you will receive an email with instructions to reset your password."
    end
end