json.(post, *Post::JSON_ATTRIBUTES)
json.published_at I18n.l(post.created_at, format: :actual)
if @category.personal_post? && post.image.attached?
  json.image_url Rails.application.routes.url_helpers.rails_representation_url(post.image.variant(resize: "220x220").processed)
end