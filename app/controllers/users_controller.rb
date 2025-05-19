# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    #   redirect_to users_path, alert: t('activerecord.errors.messages.record_not_found', model: User.model_name.human)
  end
end
