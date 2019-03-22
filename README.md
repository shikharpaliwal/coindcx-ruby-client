# CoinDCX

<a href="https://badge.fury.io/rb/coindcx"><img src="https://badge.fury.io/rb/coindcx.svg" alt="Gem Version" height="18"></a>

A Ruby library to access coindcx exchange APIs.

### Note

Currently this libarary supports REST only.
All the endpoints taken from <a href="https://coindcx-official.github.io/rest-api" target="_blank">coindcx official doc</a>.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coindcx'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coindcx

## Usage

### You can get your API key and Secret as follows

1. Go to your CoinDCX profile section
2. Click Access API dashboard
3. Click Create API key button and follow the process of verifications


### Example

```ruby
require 'coindcx'

# Access public endpoints
client = Coindcx::Rest::Client.new

# Access private endpoints
client = Coindcx::Rest::Client.new key, secret
```

---

## Public Endpoints

### # Get Tickers
```ruby
client.tickers

# RESPONSE:

# {"BTC_INR":{"id":632526,"percentChange":"-1.131","high24hr":"287957.0","low24hr":"280100.01","last":"282000.99","highestBid":"282001.00000000","lowestAsk":"284999.00000000","isFrozen":"0","quoteVolume":"2.89293","baseVolume":"822586.0723586"},"MDA_BTC":{"id":633389,"percentChange":"0.024","high24hr":"0.00026000","low24hr":"0.00023050","last":"0.00024516","highestBid":"0.00024515","lowestAsk":"0.00024537","isFrozen":"0","quoteVolume":"347.0","baseVolume":"0.08511527"},"XLM_BTC"....}
```

### # Get Markets
```ruby
client.markets

# RESPONSE:

# [
#   "SNTBTC",
#   "TRXBTC",
#   "TRXETH"
#   .
#   .
# ]
```

### # Get markets etails
```ruby
client.markets_details

# RESPONSE:

# [
#   {
#     "coindcx_name":               "SNTBTC",
#     "base_currency_short_name":   "BTC",
#     "target_currency_short_name": "SNT",
#     "target_currency_name":       "Status",
#     "base_currency_name":         "Bitcoin",
#     "min_quantity":               1,
#     "max_quantity":               1000000,
#     "min_notional":               0.001,
#     "base_currency_precision":    8,
#     "target_currency_precision":  0,
#     "step":                       1,
#     "order_types":                ["market_order", "limit_order"]
#   }
# ]
```

### # Get trades
```ruby
client.trades({"market" => "LTCBTC"})

# RESPONSE:

# [
#   {
#     "p":  0.00001693,
#     "q":  394,
#     "T":  1521476030955.09,
#     "m":  false
#   }
# }
```

### # Get order books
```ruby
client.order_books({"market" => "LTCBTC"})

# RESPONSE:

# {  
#   "asks":{
#     "0.00160900":"23.79000000",
#     "0.00161000":"300.85",
#     "0.00161400":"11.25",
#     "0.00161500":"101.82",
#     "0.00161700":"222.37000000"
#     ,
#     ,
#     ,
#   },
#   "bids":{  
#     "0.00160400":"24.24000000",
#     "0.00160300":"7.63",
#     "0.00160100":"917.51000000",
#     "0.00159900":"40.8",
#     "0.00159700":"6"
#     ,
#     ,
#     ,
#   }
```

---

## Private Endpoints


### # Post balances
```ruby
client.balances({"timestamp" => Time.new.to_i * 1000})

# RESPONSE:

# [
#   {
#     "currency": "BTC",
#     "balance": 1.167,
#     "locked_balance": 2.1
#   }
# ]

# Locked balance is the balance currently being used by an open order
```

### # Post place order
```ruby
payload = {
  "side" => "buy",
  "order_type" => "limit_order",
  "market" => "LTCBTC",
  "price_per_unit" => 0.00001,
  "total_quantity" => 10,
  "timestamp" => Time.new.to_i * 1000
}

client.place_order(payload)

# RESPONSE:

# {  
#    "orders":[  
#      {  
#         "id":"ead19992-43fd-11e8-b027-bb815bcb14ed",
#         "market":"LTCBTC",
#         "order_type":"limit_order",
#         "side":"buy",
#         "status":"open",
#         "fee_amount":0.0000008,
#         "fee":0.1,
#         "total_quantity":10.0,
#         "remaining_quantity":10.0,
#         "avg_price":0.0,
#         "price_per_unit":0.00001,
#         "created_at":"2018-04-19T18:17:28.022Z",
#         "updated_at":"2018-04-19T18:17:28.022Z"
#      }
#    ]
# }
```

### # Post place multiple orders
```ruby
payload = {"orders":[{
  "side" => "buy",
  "order_type" => "limit_order",
  "market" => "LTCBTC",
  "price_per_unit" => 0.00001,
  "total_quantity" => 10,
  "timestamp" => Time.new.to_i * 1000
 },
 {
  "side" => "buy",
  "order_type" => "limit_order",
  "market" => "LTCBTC",
  "price_per_unit" => 0.00001,
  "total_quantity" => 10,
  "timestamp" => Time.new.to_i * 1000
 }],
}
client.place_multiple_orders(payload)

# RESPONSE:

# {  
#    "orders":[  
#      {  
#         "id":"ead19992-43fd-11e8-b027-bb815bcb14ed",
#         "market":"LTCBTC",
#         "order_type":"limit_order",
#         "side":"buy",
#         "status":"open",
#         "fee_amount":0.0000008,
#         "fee":0.1,
#         "total_quantity":10.0,
#         "remaining_quantity":10.0,
#         "avg_price":0.0,
#         "price_per_unit":0.00001,
#         "created_at":"2018-04-19T18:17:28.022Z",
#         "updated_at":"2018-04-19T18:17:28.022Z"
#      }
#    ]
# }
```

### # POST order status
```ruby
payload = {"id" => "ead19992-43fd-11e8-b027-bb815bcb14ed", "timestamp" => Time.new.to_i * 1000}

client.order_status(payload)

# RESPONSE:

# {  
#   "id":"ead19992-43fd-11e8-b027-bb815bcb14ed",
#   "market":"TRXETH",
#   "order_type":"limit_order",
#   "side":"buy",
#   "status":"open",
#   "fee_amount":0.0000008,
#   "fee":0.1,
#   "total_quantity":2,
#   "remaining_quantity":2.0,
#   "avg_price":0.0,
#   "price_per_unit":0.00001567,
#   "created_at":"2018-04-19T18:17:28.022Z",
#   "updated_at":"2018-04-19T18:17:28.022Z"
# }
```

### # POST multiple order status
```ruby
payload = {
  "ids": ["8a2f4284-c895-11e8-9e00-5b2c002a6ff4", "8a1d1e4c-c895-11e8-9dff-df1480546936"]
}
client.multiple_order_status(payload)

# RESPONSE:

# [
#   {  
#     "id":"ead19992-43fd-11e8-b027-bb815bcb14ed",
#     "market":"LTCBTC",
#     "order_type":"limit_order",
#     "side":"buy",
#     "status":"open",
#     "fee_amount":0.0000008,
#     "fee":0.1,
#     "total_quantity":2,
#     "remaining_quantity":2.0,
#     "avg_price":0.0,
#     "price_per_unit":0.00001567,
#     "created_at":"2018-04-19T18:17:28.022Z",
#     "updated_at":"2018-04-19T18:17:28.022Z"
#   }
# ]
```

### # POST active orders
```ruby
payload = {
  "side" => "buy",
  "market" => "LTCBTC",
  "timestamp" => Time.new.to_i * 1000
}

client.active_orders(payload)

# RESPONSE:

# [
#   {  
#     "id":"ead19992-43fd-11e8-b027-bb815bcb14ed",
#     "market":"LTCBTC",
#     "order_type":"limit_order",
#     "side":"buy",
#     "status":"open",
#     "fee_amount":0.0000008,
#     "fee":0.1,
#     "total_quantity":2,
#     "remaining_quantity":2.0,
#     "avg_price":0.0,
#     "price_per_unit":0.00001567,
#     "created_at":"2018-04-19T18:17:28.022Z",
#     "updated_at":"2018-04-19T18:17:28.022Z"
#   }
# ]
```

### # POST trade history
```ruby
payload = {
  "from_id" => 352622,
  "limit" => 50
}

client.trade_history(payload)

# RESPONSE:

# [ 
#   {
#     "id": 564389,
#     "order_id": "ee060ab6-40ed-11e8-b4b9-3f2ce29cd280",
#     "side": "buy",
#     "fee_amount": "0.00001129",
#     "ecode": "B",
#     "quantity": 67.9,
#     "price": 0.00008272,
#     "symbol": "LTCBTC",
#     "timestamp": 1533700109811
#   } 
# ]
```

### # POST active orders count
```ruby
payload = {
  "side" => "buy",
  "market" => "LTCBTC",
  "timestamp" => Time.new.to_i * 1000
}

client.active_orders_count(payload)

# RESPONSE:

# { 
#   count: 1,
#   status: 200
# }
```

### # POST cancel all orders
```ruby

payload = {
  "side" => "buy",
  "market" => "LTCBTC",
  "timestamp" => Time.new.to_i * 1000
}

client.cancel_all_orders(payload)

# RESPONSE:

# {"message"=>"success", "status"=>200, "code"=>200}
```

### # POST cancel orders by ids
```ruby
payload = {
  "ids": ["8a2f4284-c895-11e8-9e00-5b2c002a6ff4", "8a1d1e4c-c895-11e8-9dff-df1480546936"]
}

client.cancel_orders_by_ids(payload)

# RESPONSE:

# {"message"=>"success", "status"=>200, "code"=>200}
```

### # POST cancel_order
```ruby
payload = {"id" => "ead19992-43fd-11e8-b027-bb815bcb14ed", "timestamp" => Time.new.to_i * 1000}

client.cancel_order(payload)

# RESPONSE:

# {"message"=>"success", "status"=>200, "code"=>200}
```

---

## Errors

| Error Code    | Meaning
| ------------- |:-------------:|
|      400      | Bad Request -- Your request is invalid.|
|      401      | Your API key is wrong.|
|      402      | Invalid Request.|
|      404      | The specified link could not be found.|
|      429      | Too Many Requests -- You're making too many API calls.|
|      500      | Internal Server Error -- We had a problem with our server. Try again later.|
|      503      | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.|

---

## API call limits

Typically you can place around 4 orders per second. The exact number depends on the server load. In aggregate, you may call https//api.coindcx.com not more than 10 times per second.

---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/coindcx-official/coindcx-ruby-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Coindcx::Ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/coindcx-official/coindcx-ruby-client/blob/master/CODE_OF_CONDUCT.md).
