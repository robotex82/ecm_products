include ActiveAdmin::ActsAsList::Helper if defined?(::ActiveAdmin)

::ActiveAdmin.register Ecm::Products::ProductPicture do
  # menu entry settings
  menu :parent => Proc.new { I18n.t('ecm.products.active_admin.menu') }.call

  # acts as list
  sortable_member_actions

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :ecm_products_product
      f.input :name
      f.input :description
      f.input :image, :as => :file
    end

    f.inputs do
      f.input :markup_language, :as => :select, :collection => Ecm::Products::ProductPicture::MARKUP_LANGUAGES
    end
    f.actions
  end

  index do
    selectable_column
    column :thumbnail do |pp|
      link_to(image_tag(pp.image.url(:medium_thumb)), [:admin, pp])
    end
    column :ecm_products_product
    column :name
    column :description
    column :created_at
    column :updated_at
    default_actions
  end
end if defined?(::ActiveAdmin)

