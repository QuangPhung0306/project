class Api::V1::PostsController < Api::V1::BaseController
  before_action :load_category, only: :index
  def index
    respond_to do |format|
      @posts = @category.posts.select(Post::JSON_ATTRIBUTES)
        .with_attached_image.order(:order_enum).page(params[:page])
      format.json
    end
  end

  def show
    respond_to do |format|
      @post = Post.find_by_id params[:id]
      format.json
    end
  end

  private
  def load_category
    @category = Category.find_by_id params[:category_id]
  end
end