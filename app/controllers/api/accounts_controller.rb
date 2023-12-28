# frozen_string_literal: true

module Api
  class AccountsController < ApplicationController
    before_action :authenticate_auth!

    def index
      @accounts = Profile.with_auth
      @total_records = @accounts
      @total_pages = total_pages(@accounts)
      @accounts = paginate(@accounts)
    end

    def show
      @account = Profile.with_auth.find(params[:id])
    end
  end
end
