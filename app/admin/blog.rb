ActiveAdmin.register Blog do
  permit_params :domain, :title_selector, :content_selector

  index do
    selectable_column
    column :id
    column :domain
    column :title_selector
    column :content_selector
    column :created_at
    actions do |post|
      link_to "Link", admin_link_path(post), class: "member_link"
    end
  end

  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :domain
      f.input :title_selector
      f.input :content_selector
    f.has_many :links do |link|
        link.input :path
        link.input :whitelist
        link.input :blacklist
        link.input :unreachable
    end
    end

    f.actions
  end

end
