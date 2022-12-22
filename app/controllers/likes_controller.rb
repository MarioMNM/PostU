class LikesController < ApplicationController
   before_action :find_post
   
  def create
    @micropost.likes.create(user_id: current_user.id)
    redirect_to micropost_path(@micropost)
  end
  
  private
  
    def find_post
      @micropost = Micropost.find(params[:micropost_id])
    end
end