json.status 'success'
json.data do
  json.category do
    json.(@category, :id, :name, :type_enum, :description, :slug)
  end
  json.totalPages @posts.total_pages
  json.page (params[:page] || 1).to_i
  json.collection do
    json.array! @posts, partial: 'api/v1/posts/post', as: :post
  end
end

