ActiveAdmin.register Post do
  includes :category
  permit_params :title, :content, :category_id, :slug, :seo_description, :seo_keywords, 
    :order_enum, :image
  config.sort_order = 'order_enum_asc'
  config.per_page = [10, 30, 50]
  config.create_another = true
  filter :title_or_content_cont, as: :string, label: 'Title or content'
  filter :created_at
  batch_action :pushlish, priority: 100, confirm: 'Bạn có chắc muốn publish các bài viết này ?' do |ids|
    batch_action_collection.find(ids).each do |post|
      puts 'placeholder'
    end
    redirect_to collection_path, alert: "The posts have been published."
  end

  index do
    category = Category.find(params[:category_id])
    old_params = params.to_json
    selectable_column
    column 'Tiêu đề' , :title
    if category.personal_post?
      column 'Ảnh đại diện' do |post|
        div image_tag(post.image.representation(resize_to_limit: [220, 220]), width: 80) if post.image.attached?
      end
    end
    column 'Ngày tạo', :created_at
    column do |post|
      span link_to("&darr;".html_safe, change_sort_admin_category_post_path(category_id: post.category.id, 
        id: post.id, sort: 'down', old_params: old_params)), class: "sort-link-down"  # sort down
      span "&nbsp;".html_safe
      span link_to("&uarr;".html_safe, change_sort_admin_category_post_path(category_id: post.category.id, 
        id: post.id, sort: 'up', old_params: old_params)), class: "sort-link-up"  # sort up
    end

    actions

    script do
      code = '$(".sort-link-up").first().hide();' \
      '$(".sort-link-down").last().hide()'
      raw code
    end
  end

  show do
    tabs do
      tab 'Cơ bản' do
        attributes_table do    
          row('Tiêu đề'){|post| post.title}
          row('Ảnh đại diện'){|post| image_tag(resource.image.representation(resize_to_limit: [220, 220]))} if resource.image.attached?
          row :category
          row('Thứ tự'){|post| post.order_enum}
          row :slug
          row('Ngày tạo'){|post| post.created_at}
          row :seo_description
          row :seo_keywords
        end
      end
      tab 'Nội dung' do
        raw(post.content)
      end
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    tabs do
      tab 'Cơ bản' do
        f.inputs 'Thông tin cơ bản' do
          f.input :title, label: 'Tiêu đề'
          f.input :category, as: :select
          f.input :slug unless f.object.new_record?
          if f.object.category.personal_post?
            if f.object.image.attached?
              li class: "show-image" do
                label "Ảnh đã upload", class: "label"
                div image_tag(f.object.image.representation(resize_to_limit: [220, 220]))
              end
            end
            f.input :image, as: :file, label: 'Ảnh đại diện'
          end
        end
        f.inputs 'Thông tin cho Seo' do
          f.input :seo_description
          f.input :seo_keywords
        end
      end
      tab 'Nội dung bài viết' do
        f.inputs do
          f.input :content, as: :ckeditor, label: false, input_html: {ckeditor: {height: 800}}
        end
      end
    end
    actions
  end

  member_action :change_sort, method: :get do
    old_params = JSON.parse(params[:old_params])
    posts = posts_from_old_params(old_params).to_a
    current_post_index = posts.index{|post| post.id == resource.id}
    next_to_posts = []

    case params[:sort]
    when 'up' then
      new_order_enum = posts[current_post_index - 1].order_enum
      posts.each do |post|
        next if post.order_enum != new_order_enum
        post.order_enum = resource.order_enum
        next_to_posts.push post
      end
      resource.order_enum = new_order_enum
    when 'down' then
      new_order_enum = posts[current_post_index + 1].order_enum
      posts.each do |post|
        next if post.order_enum != new_order_enum
        post.order_enum = resource.order_enum
        next_to_posts.push post
      end
      resource.order_enum = new_order_enum
    end
    next_to_posts.push(resource).each(&:save)
    redirect_to old_params
  end

  controller do
    def scoped_collection
      end_of_association_chain.with_attached_image
    end

    before_create do |post|
      post.order_enum = 1
      Post.update_all('order_enum = order_enum + 1')
    end

    def posts_from_old_params old_params
      @q = scoped_collection.ransack(old_params['q'])
      if order = old_params['order']
        column_order = order.sub(/_asc|_desc/, '')
        direct_order = order.split('_').last
        @q.result.order("#{column_order} #{direct_order}")
      else
        @q.result
      end.page(old_params['page']).per(old_params['per_page'] || 10)
    end
  end
end