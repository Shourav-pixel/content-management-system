# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = User.find(params[:id])
      @support_tickets = @user.support_tickets.paginate(page: params[:page], per_page: 10)
    end
  end
  