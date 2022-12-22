class LikesController < ApplicationController
   before_action :find_post
   
  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @micropost.likes.create(user_id: current_user.id)
    end
    redirect_to micropost_path(@micropost)
  end
  
  private
  
    def find_post
      @micropost = Micropost.find(params[:micropost_id])
    end
    
    def already_liked?
      Like.where(user_id: current_user.id, micropost_id:
                 params[:micropost_id]).exists?
    end
end