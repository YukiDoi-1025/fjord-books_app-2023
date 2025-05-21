# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]
  before_action :set_commentable

  def index
    @comments = Comment.all
  end

  def show; end

  def new
    @comment = @commentable.comments.new
  end

  def edit; end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.user = current_user
    @comment.commentable = @commentable

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        format.html { redirect_to @comment.commentable, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to polymorphic_url([@commentable, @comment]), notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
    end
  end

  private

  def set_commentable
    @commentable = if params[:book_id]
                     Book.find(params[:book_id])
                   elsif params[:report_id]
                     Report.find(params[:report_id])
                   end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:article)
  end

  def ensure_correct_user
    @comment = Comment.find(params[:id])
    return unless @comment.user_id != current_user.id

    flash[:notice] = t('controllers.common.notice_invalid_user')
    redirect_to @comment.commentable
  end
end
