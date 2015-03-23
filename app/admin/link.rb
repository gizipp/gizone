ActiveAdmin.register Link do
  permit_params :path, :whitelist, :blacklist, :unreachable

  # scope :all, default: true
  # scope :whitelist
  # scope :blacklist

  index do
    selectable_column
    column :id
    column :path
    column :whitelist
    column :blacklist
    column :unreachable
    column :blog
    column :created_at
    actions
  end

  filter :created_at
  filter :blog_id

  form do |f|
    f.inputs "Link Details" do
      f.input :path
      f.input :whitelist
      f.input :blacklist
      f.input :unreachable
    end

    f.actions
  end

end
