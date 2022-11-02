class ApplicationController < Sinatra::Base
  # Set the default response content type to 'application/json
  set :default_content_type, "application/json"

  # add routes
  get "/bakeries" do
    # gets all bakeries from the database
    bakeries = Bakery.all

    # Returns an json response of an array of bakeries
    bakeries.to_json
  end

  get "/bakeries/:id" do
    # gets a specific bakery by id
    bakery = Bakery.find(params[:id])

    # returns a json reponse of the bakery details
    bakery.to_json(include: :baked_goods)
  end

  get "/baked_goods/by_price" do
    # gets all baked goods and sorts them by price
    baked_goods = BakedGood.all.order(price: :desc)

    # Converts the array into a json representation
    baked_goods.to_json
  end

  get "/baked_goods/most_expensive" do
    # returns the single most expensive baked good
    highest_price = BakedGood.maximum(:price)
    # returns response as a json representation
    most_expensive_baked_good  = BakedGood.find_by(price: highest_price).to_json

  end
end
