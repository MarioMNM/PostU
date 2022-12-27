class LikesController < ApplicationController
   before_action :find_post
   before_action :find_like, only: [:destroy]
   
  def create
    if !(already_liked?)
      @micropost.likes.create(user_id: current_user.id)
    end
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    if already_liked?
      @like.destroy
    end
    redirect_back(fallback_location: root_path)
  end
  
  private
  
    def find_post
      @micropost = Micropost.find(params[:micropost_id])
    end
    
    def already_liked?
      Like.where(user_id: current_user.id, micropost_id:
                 params[:micropost_id]).exists?
    end
    
    def find_like
      @like = @micropost.likes.find(params[:id])
    end
end