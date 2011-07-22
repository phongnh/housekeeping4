class App::CategoriesController < ApplicationController
  def index
    @categories = Category.root.page(params[:page]).per(10)
  end

end

