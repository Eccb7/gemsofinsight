class HomeController < ApplicationController
  def index
    @carousel_images = ["images1.jpeg", "images2.jpeg", "images3.jpeg"]
    @main_products = Product.take(8)
    @main_categories = Category.take(4)
  end
end
