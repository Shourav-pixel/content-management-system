class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :restrict_to_post_request, only: [:bulk_actions]

  def index
    @users = User.all
  end

  def bulk_actions
    action = params[:button]
    user_ids = params[:user_ids]

    case action
    when 'block'
      User.where(id: user_ids).update_all(status: 'blocked')
      redirect_to admin_users_path, notice: "#{user_ids.count} users blocked successfully"
    when 'unblock'
      User.where(id: user_ids).update_all(status: 'active')
      redirect_to admin_users_path, notice: "#{user_ids.count} users unblocked successfully"
    when 'delete'
      User.where(id: user_ids).destroy_all
      redirect_to admin_users_path, notice: "#{user_ids.count} users deleted successfully"
    else
      redirect_to admin_users_path, alert: 'Invalid action'
    end
  end

  private

  def restrict_to_post_request
    unless request.post?
      redirect_to admin_users_path, alert: 'Invalid request'
    end
  end
end
