json.(category, *Category::JSON_ATTRIBUTES)
if category.image.attached?
  json.image_url Rails.application.routes.url_helpers.rails_representation_url(category.image.variant(resize: "260x260").processed)
else
  json.image_url nil
end
