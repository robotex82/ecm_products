::ActiveAdmin.register Ecm::Products::ProductLink do
  # menu entry settings
  menu :parent => Proc.new { I18n.t('ecm.products.active_admin.menu') }.call

  # acts as list
  sortable_member_actions

  form do |f|
    f.inputs do
      f.input :ecm_products_product
      f.input :name
      f.input :url
      f.input :description
    end

    f.inputs do
      f.input :markup_language, :as => :select, :collection => Ecm::Products::Configuration.markup_languages
    end

    f.actions
  end

  index do
    selectable_column
    column :ecm_products_product
    column :name
    column :description
    column :url
    default_actions
  end

  show do
    attributes_table do
      row :ecm_products_product
      row :name
      row :url do |pl|
        link_to(pl.url, pl.url)
      end
      row :markup_language
      row :created_at
      row :updated_at
    end

    panel Ecm::Products::ProductLink.human_attribute_name(:description) do
      div { ecm_products_product_link.description }
    end
  end
end if defined?(::ActiveAdmin)

