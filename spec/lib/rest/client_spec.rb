RSpec.describe Coindcx::Rest::Client do
  it "should success" do
    client = Coindcx::Rest::Client.new("key", "secret")

    # Public endpoints
    expect(client).to respond_to(:tickers).with(1).argument

    expect(client).to respond_to(:markets).with(1).argument

    expect(client).to respond_to(:markets_details).with(1).argument

    expect(client).to respond_to(:trades).with(1).argument

    expect(client).to respond_to(:order_books).with(1).argument

    # Private endpoints
    expect(client).to respond_to(:balances).with(1).argument

    expect(client).to respond_to(:place_order).with(1).argument

    expect(client).to respond_to(:place_multiple_orders).with(1).argument

    expect(client).to respond_to(:order_status).with(1).argument

    expect(client).to respond_to(:multiple_order_status).with(1).argument

    expect(client).to respond_to(:active_orders).with(1).argument

    expect(client).to respond_to(:trade_history).with(1).argument

    expect(client).to respond_to(:active_orders_count).with(1).argument

    expect(client).to respond_to(:cancel_all_orders).with(1).argument

    expect(client).to respond_to(:cancel_orders_by_ids).with(1).argument

    expect(client).to respond_to(:cancel_order).with(1).argument

    expect(client).not_to respond_to(:fakemethod).with(1).argument

  end
end