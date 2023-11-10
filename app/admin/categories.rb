ActiveAdmin.register Category do
  sidebar "Category Details", only: [:show, :edit] do
    ul do
      li link_to "Danh sách bài viết", admin_category_posts_path(resource)
    end
  end
  menu label: "Loại bài viết", priority: 1
  permit_params :name, :description, :type_enum, :order_enum, :slug, :image
  config.sort_order = 'order_enum_asc'
  config.create_another = true
  filter :name_or_description_cont, as: :string, label: 'Name or description'
  filter :created_at

  index do
    old_params = params.to_json
    selectable_column
    column 'Tên', :name
    column 'Ảnh' do |category|
      text_node image_tag(category.image.representation(resize_to_limit: [260, 260]), width: 80) if category.image.attached?
    end
    column 'Mô tả' do |category|
      div category.description.html_safe
    end
    column 'Ngày tạo', :created_at
    column do |category|
      span link_to("&darr;".html_safe, change_sort_admin_category_path(id: category.id, 
        sort: 'down', old_params: old_params)), class: "sort-link-down"  # sort down
      span "&nbsp;".html_safe
      span link_to("&uarr;".html_safe, change_sort_admin_category_path(id: category.id, 
        sort: 'up', old_params: old_params)), class: "sort-link-up"  # sort up
    end
    actions dropdown: true do |category|
      item "Danh sách bài viết", admin_category_posts_path(category)
    end

    script do
      code = '$(".sort-link-up").first().hide();' \
      '$(".sort-link-down").last().hide()'
      raw code
    end
  end

  show do
    attributes_table do
      row('Tên'){|category| category.name}
      row('Mô tả'){|category| simple_format(category.description)}
      row('Loại'){|category| category.type_enum.upcase}
      row('Thứ tự'){|category| category.order_enum}
      row :slug
      row('Ngày tạo'){|category| category.created_at}
      row('Ảnh'){|category| image_tag(category.image.representation(resize_to_limit: [260, 260]))} if resource.image.attached?
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :type_enum, as: :radio, collection: [['Tutorial', 'tutorial'], ['IT Post', 'it_post'], 
        ['Personal Post', 'personal_post']], label: 'Phân loại'
      f.input :slug unless f.object.new_record?
      if f.object.image.attached?
        li class: "show-image" do
          label "Ảnh đã upload", class: "label"
          div image_tag(f.object.image.representation(resize_to_limit: [260, 260]))
        end
      end
      f.input :image, as: :file, label: "Upload ảnh mới"
    end
    f.inputs 'Description' do
      f.input :description, as: :ckeditor, label: false
    end
    actions
  end

  member_action :change_sort, method: :get do
    old_params = JSON.parse(params[:old_params])
    categories = categories_from_old_params(old_params).to_a
    current_category_index = categories.index{|category| category.id == resource.id}
    next_to_categories = []

    case params[:sort]
    when 'up' then
      new_order_enum = categories[current_category_index - 1].order_enum
      categories.each do |category|
        next if category.order_enum != new_order_enum
        category.order_enum = resource.order_enum
        next_to_categories.push category
      end
      resource.order_enum = new_order_enum
    when 'down' then
      new_order_enum = categories[current_category_index + 1].order_enum
      categories.each do |category|
        next if category.order_enum != new_order_enum
        category.order_enum = resource.order_enum
        next_to_categories.push category
      end
      resource.order_enum = new_order_enum
    end
    next_to_categories.push(resource).each(&:save)
    redirect_to old_params
  end

  controller do
    def scoped_collection
      end_of_association_chain.with_attached_image              # solve n + 1 query when display image in index page
    end

    before_create do |category|
      category.order_enum = 1
      Category.update_all('order_enum = order_enum + 1')
    end

    def categories_from_old_params old_params
      @q = scoped_collection.ransack(old_params['q'])
      if order = old_params['order']
        column_order = order.sub(/_asc|_desc/, '')
        direct_order = order.split('_').last
        @q.result.order("#{column_order} #{direct_order}")
      else
        @q.result
      end
    end
  end
end

ActiveAdmin.register Post do
  belongs_to :category
  navigation_menu :category
end