ActiveAdmin.register_page 'TestCustomPage', namespace: 'test' do  # available at /test/testcustompage
  menu label: 'Test Custom Page', priority: 11
  breadcrumb do
    ['admin', 'Test']
  end
  action_item :view_site do
    link_to "View Site", "/"
  end
  action_item :add_event do
    link_to "Add Event", test_testcustompage_add_event_path, method: :post
  end
  sidebar 'Sidebar' do
    ul do
      li link_to('Test', '#')
    end
  end

  page_action :add_event, method: :post do   # Add a action for controller
    #...
    redirect_to test_testcustompage_path, notice: "Your event was added"
  end

  content do
    render partial: 'admin/testcustompage/calendar'
    panel 'Test arbre' do
      para 'test sample para'

      # columns
      columns do
        column span: 2, class: "column column-test" do
          span "column #1"
        end
        column max_width: "200px", min_width: "100px" do
          span "column #2"
        end
      end

      # Table

      table_for Category.all do
        column(:name) { |c| c.name.titleize }
        column "Desc",     :description
        column "Created at", :created_at
      end

      # status tag

      status_tag 'In Progress'

      status_tag 'active', class: 'important', id: 'status_123', label: 'on'
      status_tag true
      tabs do
        tab :active do
          div do
            h1 "Tab1"
          end
        end

        tab :inactive do
          div do
            h1 "Tab2"
          end
        end
      end
    end
  end
end