# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_auth!

  def show
    @profile = Profile.with_auth.find_by(auths: { email: current_auth.email })
  end

  def update
    @profile = Profile.with_auth.find_by(auths: { email: current_auth.email })
    if @profile.update!(profile_params)
      flash[:success] = 'Update your profiles successfully!'
      redirect_to account_path(@profile.auth.id)
    else
      flash[:alert] = 'Some thing was wrong!'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:auth_id, :name, :username, :position, :avatar, skills: []) do |p|
      p[:skills] = p[:skills].reject(&:empty?) if p[:skills].present?
    end
  end
end
