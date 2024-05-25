class SearchQueriesController < ApplicationController
  protect_from_forgery except: [:create, :suggest]

  def index
    @search_queries = SearchQuery.group(:query).count
  end

  def create
    query = params[:search_query][:query]
    complete = params[:search_query][:complete]
    if complete
      # Log complete query
      SearchQuery.create(query: query)
    end
    # Always respond with suggestions for the query
    suggestions = SearchQuery.where('query LIKE ?', "%#{query}%").pluck(:query).uniq
    render json: suggestions
  end

  def suggest
    query = params[:query]
    suggestions = SearchQuery.where("query LIKE ?", "%#{query}%").pluck(:query).uniq
    render json: suggestions
  end

  def trends
    trends = SearchQuery.group(:query).count
    render json: trends.map { |query, count| { query: query, count: count } }
  end

  private

  def search_query_params
    params.require(:search_query).permit(:query)
  end
end
