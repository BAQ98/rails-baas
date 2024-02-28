# frozen_string_literal: true

class PasswordsController < ApplicationController
  def forgot
    render 'devise/passwords/forgot'
  end

  def send_token
    @auth = Auth.find_by(email: params[:auth][:email])
    if @auth
      AuthMailer.send_reset_password_instructions(@auth).deliver
      respond_to do |format|
        flash[:notice] = "Token have been sent! Check your email"
        format.html { redirect_to forgot_password_path }
      end
    else
      respond_to do |format|
        flash[:error] = "Email doesn't exist"
        format.html { redirect_to forgot_password_path }
      end
    end

  end

end