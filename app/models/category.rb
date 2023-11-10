class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :name, :description, :type_enum, presence: true
  validates :slug, presence: true, on: :update
  validates :slug, uniqueness: true
  # validates :image, attached: true, content_type: %i[png jpg jpeg]

  enum type_enum: {tutorial: 1, it_post: 2, personal_post: 3}

  has_one_attached :image

  JSON_ATTRIBUTES = %i(id name description type_enum order_enum slug)

  after_create do
    self.update slug: "#{name.convert_vietnamese_to_unicode}-#{id}"
  end
end
