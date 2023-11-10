json.status 'success'
json.data do
  json.(@post, *[:id, :title, :content, :slug, :seo_description, :seo_keywords, :category_id])
  json.published_at I18n.l(@post.created_at, format: :actual)
end
