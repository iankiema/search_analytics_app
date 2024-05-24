require 'rails_helper'

RSpec.describe "SearchQueries", type: :request do
  describe "POST /search_queries" do
    it "logs complete search queries" do
      post '/search_queries', params: { search_query: { query: 'Complete search query', complete: true } }
      expect(response).to have_http_status(:success)
    end

    it "logs partial search queries" do
      post '/search_queries', params: { search_query: { query: 'Partial search query', complete: false } }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /search_queries/suggest" do
    it "fetches search suggestions" do
      post '/search_queries/suggest', params: { query: 'Partial search query' }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /search_queries/trends" do
    it "fetches and displays search trends" do
      get '/search_queries/trends'
      expect(response).to have_http_status(:success)
    end
  end
end
