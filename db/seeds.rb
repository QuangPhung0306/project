# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

20.times do |i|
  p = Post.new title: "Personal Post 31/1/2021 sample post #{101 + i}", content: 'sample content', 
    seo_description: 'sample', seo_keywords: 'sample', order_enum: (101 + i), category_id: 7
  p.image.attach(io: File.open('tmp/imgs/du_lich.jpg'), filename: 'du_lich.jpg')
  p.save
end
