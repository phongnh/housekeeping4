class App::CategoriesController < AppController
  def index
    @categories = Category.root
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to app_categories_path
    else
      render :action => "index"
    end
  end

end

