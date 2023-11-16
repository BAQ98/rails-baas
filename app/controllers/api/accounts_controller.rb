module Api
  class AccountsController < ApplicationController
    def index
      @accounts = Auth.all
      @total_pages = total_pages(@accounts)
      @accounts = paginate(@accounts)
    end

    def show
      @account = Auth.find(params[:id])
    end

    def create
      @account = Auth.new(params[:email])
    end

    def update
      @account = Auth.find(params[:id])
    end

    def update
      @account = Object.find(params[:id])
      if @account.update_attributes(params[:password])
        flash[:success] = "Object was successfully updated"
        redirect_to @account
      else
        flash[:error] = "Something went wrong"
        render "edit"
      end
    end

    def destroy
      @account = Auth.find(params[:id])
      if @account.destroy
        flash[:success] = "Account was successfully deleted."
        redirect_to accounts_path
      else
        flash[:error] = "Something went wrong"
        redirect_to accounts_path
      end
    end
  end
end
