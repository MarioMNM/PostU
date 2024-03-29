class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def show
    begin
      @micropost = Micropost.find(params[:id])
      @comments = @micropost.comments.order(created_at: :desc)
      mark_notifications_as_read
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:id, :content, :image)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @micropost.nil?
    end

    def mark_notifications_as_read
      if current_user && session[:user_id] == @micropost.user_id
        notifications_to_mark_as_read = Notification.where(recipient: @micropost.user_id)
        notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
      end
    end
end