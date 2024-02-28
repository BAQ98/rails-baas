# frozen_string_literal: true

class PasswordsController < ApplicationController
  def forgot
    render 'devise/passwords/forgot'
  end

  def send_token
    @auth = Auth.find_by(email: params[:auth][:email])
    if @auth
      @auth.send_reset_password_instructions
      respond_to do |format|
        format.html { redirect_to forgot_password_path, notice: "Token have been sent to #{@auth.email}! Check your email" }
      end
    else
      respond_to do |format|
        flash[:error] = "Email doesn't exist"
        format.html { redirect_to forgot_password_path, error: "Email doesn't exist" }
      end
    end

  end

end