class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to users_path, alert: t('errors.record_not_found', model: User.model_name.human)
  end
end
