class SearchController < ApplicationController
  
  def index
    @query = Micropost.ransack(params[:q])
    @microposts = @query.result.includes(:user)
  end
end
