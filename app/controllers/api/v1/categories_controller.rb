class Api::V1::CategoriesController < Api::V1::BaseController
  def index
    respond_to do |format|
      @categories = Category.all.select(Category::JSON_ATTRIBUTES)
        .with_attached_image.order(:order_enum)
      format.json
    end
  end
end