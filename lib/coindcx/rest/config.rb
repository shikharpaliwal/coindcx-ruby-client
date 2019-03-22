module Coindcx
  module Rest
    class Config

      # BASE_URL = 'http://localhost:3000/exchange'.freeze
      # BASE_URL = 'https://api.coindcx.com/exchange'.freeze
      BASE_URL = 'https://staging-api.coindcx.com/exchange'.freeze
      ENDPOINTS = {
        "ticker" => {
          "endpoint" => "/v1/ticker",
          "parameters" => {
            "type" => "query",
          },
          "method" => "GET",
          "authentication" => false
        },
        "markets" => {
          "endpoint" => "/v1/markets",
          "parameters" => {
            "type" => "query",
          },
          "method" => "GET",
          "authentication" => false
        },
        "markets_details" => {
          "endpoint" => "/v1/markets_details",
          "parameters" => {
            "type" => "query",
          },
          "method" => "GET",
          "authentication" => false
        },
        "trades" => {
          "endpoint" => "/v1/trades/:market",
          "parameters" => {
            "type" => "url",
            "replace" => {
              ":market" => "market"
            }
          },
          "method" => "GET",
          "authentication" => false
        },
         "order_books" => {
          "endpoint" => "/v1/books/:market",
          "parameters" => {
            "type" => "url",
            "replace" => {
              ":market" => "market"
            }
          },
          "method" => "GET",
          "authentication" => false
        },
        "tickers" => {
          "endpoint" => "/v1/tickers",
          "parameters" => {
            "type" => "query",
            "replace" => {
              "market" => "market"
            }
          },
          "method" => "GET",
          "authentication" => false
        },
        # END public endpoints

        #START Private end points
        "balances" => {
          "endpoint" => "/v1/users/balances",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
        "place_order" => {
          "endpoint" => "/v1/orders/create",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
        "place_multiple_orders" => {
          "endpoint" => "/v1/orders/create_multiple",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
        "status_status" => {
          "endpoint" => "/v1/orders/status",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
        "multiple_order_status" => {
          "endpoint" => "/v1/orders/status_multiple",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
        "active_orders" => {
          "endpoint" => "/v1/orders/active_orders",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
        "trade_history" => {
          "endpoint" => "/v1/orders/trade_history",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },

        "active_orders_count" => {
          "endpoint" => "/v1/orders/active_orders_count",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
        "cancel_all_orders" => {
          "endpoint" => "/v1/orders/cancel_all",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
        "cancel_orders_by_ids" => {
          "endpoint" => "/v1/orders/cancel_by_ids",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
        "cancel_order" => {
          "endpoint" => "/v1/orders/cancel",
          "parameters" => {
            "type" => "body"
          },
          "method" => "POST",
          "authentication" => true
        },
      }.freeze

      Coindcx::Rest::Config.class_eval do
        ENDPOINTS.each do |method, method_data|
          define_method "#{method}" do |payload={}|
            http_request(method_data["method"], method_data, payload)
          end
        end
      end

    end
  end
end