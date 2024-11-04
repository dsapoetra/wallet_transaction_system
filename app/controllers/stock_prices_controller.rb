# app/controllers/stock_prices_controller.rb
class StockPricesController < ApplicationController
    before_action :set_client
  
    # GET /stock_prices/price_all
    def price_all
      prices = @client.price_all
      render json: prices, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  
    # GET /stock_prices/equities
    def equities
      equities = @client.equities
      render json: equities, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  
    private
  
    def set_client
      @client = LatestStockPrice::Client.new
    end
  end
  