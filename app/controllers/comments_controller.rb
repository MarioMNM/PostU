class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_micropost
  before_action :correct_user,   only: :destroy

  def create
    @comment = @micropost.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Comment succesfully created'
      redirect_to micropost_path(@micropost)
    else
      flash[:alert] = 'Comment has not been created'
      redirect_to micropost_path(@micropost)
    end
  end

  def destroy
    @comment = @micropost.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

    def set_micropost
      @micropost = Micropost.find(params[:micropost_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @comment.nil?
    end
end
