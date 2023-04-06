class PasswordResetsController < ApplicationController
    
    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user.present?
            # send email
            PasswordMailer.with(user: @user).reset.deliver_now
        end

        redirect_to root_path, notice: "If an account exists with this email address, you will receive an email with instructions to reset your password."
    end

    def edit
        @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to sign_in_path, alert: "Your password reset token is invalid."
    end

    def update
        @user = User.find_signed!(params[:token], purpose: "password_reset")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: "Your password has been updated. Please sign in to continue."
        else
            render :edit
        end
    end

    private 

    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end