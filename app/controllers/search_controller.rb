class SearchController < ApplicationController
  def index
    @query = Micropost.ransack(params[:q])
    @microposts = @query.result(distinct: true)
  end
end
