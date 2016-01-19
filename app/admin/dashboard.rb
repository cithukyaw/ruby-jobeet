ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
    end

    section "Recent Jobs" do
      table_for Job.order("created_at desc").limit(5) do
          column :position
          column :company
          column :location
          column :created_at
      end
      strong { link_to "View All Jobs", admin_jobs_path }
    end

    # Dashboard with columns and panels.
    columns do
      column do
        panel "Recent Posts" do
          table_for Post.order("created_at desc").limit(5) do
            column("Title"){ |post| link_to(post.title, admin_post_path(post)) }
            column :created_at
          end
        end
      end

      column do
        panel "Affiliates to activate" do
          table_for Affiliate.where("is_active = 0") do
            column :email
            column :created_at
          end
          strong { link_to "View All Affiliates", admin_affiliates_path }
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end
