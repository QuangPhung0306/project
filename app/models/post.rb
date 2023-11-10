class Post < ApplicationRecord
  belongs_to :category

  validates :title, :content, :seo_description, :seo_keywords, presence: true
  validates :slug, presence: true, on: :update
  validates :slug, uniqueness: true
  validates :image, attached: true, content_type: %i[png jpg jpeg], if: ->{category.personal_post?}

  has_one_attached :image

  JSON_ATTRIBUTES = %i(id title order_enum slug created_at seo_description)

  paginates_per 10

  scope :by_category, ->(category_id){Post.where(category_id: category_id)}

  after_create do
    self.update slug: "#{title.convert_vietnamese_to_unicode}-#{id}"
  end
end
