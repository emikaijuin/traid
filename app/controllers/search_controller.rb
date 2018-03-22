class SearchController < ApplicationController
    
  def index
    @results = PgSearch.multisearch(params[:search])
  end
  
  def ajax_city_results
    @results = User.search_cities(params["query"])
    render json: @results
  end
  
end
