include ActiveAdmin::ActsAsList::Helper if defined?(ActiveAdmin)
include ActiveAdmin::AwesomeNestedSet::Helper if defined?(ActiveAdmin)

::ActiveAdmin.register Ecm::Products::ProductCategory do
  # menu entry settings
  menu :parent => Proc.new { I18n.t('ecm.products.active_admin.menu') }.call

  # awesome nested set
  sortable_tree_member_actions

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :parent, :as => :select, :collection => nested_set_options(Ecm::Products::ProductCategory, f.object) { |pc| "#{'&#160;&#160;&#160;&#160;' * pc.level} |-- #{pc.tree_name}".html_safe }
      f.input :locale, :as => :select, :collection => I18n.available_locales.map(&:to_s)
      f.input :name
      f.input :short_description
      f.input :long_description
      f.input :preview_image, :as => :file, :hint => f.template.image_tag(f.object.preview_image.url(:medium_thumb))
      f.input :main_image, :as => :file, :hint => f.template.image_tag(f.object.main_image.url(:medium_thumb))
    end

    f.inputs do
      f.input :markup_language, :as => :select, :collection => Ecm::Products::ProductCategory::MARKUP_LANGUAGES
    end

    f.actions
  end

  index :as => :nested_set do
    selectable_column
    sortable_tree_columns
    column :preview_image do |pc|
      link_to(image_tag(pc.preview_image.url(:small_thumb)), [:admin, pc], :style => "margin-left: #{50 * pc.level}px")
    end
    column :locale
    column :name
    column :short_description
    column :ecm_products_products_count
    column :created_at
    column :updated_at
    default_actions
  end

  show :title => :to_s do
    panel Ecm::Products::ProductCategory.human_attribute_name(:main_image) do
      div { image_tag(ecm_products_product_category.main_image.url) }
    end

    panel Ecm::Products::ProductCategory.human_attribute_name(:children) do
      table_for ecm_products_product_category.descendants, :i18n => Ecm::Products::ProductCategory do
        sortable_tree_columns
        column(:name) { |child| link_to child, [:admin, child], :style => "margin-left: #{30 * (child.level -  ecm_products_product_category.level - 1)}px" }
        column :short_description
        column :ecm_products_products_count
        column :created_at
        column :updated_at
        column do |child|
          link_to(I18n.t('active_admin.view'), [:admin, child], :class => "member_link view_link") +
          link_to(I18n.t('active_admin.edit'), [:edit, :admin, child], :class => "member_link edit_link")
        end
      end
    end

    panel Ecm::Products::ProductCategory.human_attribute_name(:short_description) do
      div { ecm_products_product_category.short_description }
    end

    panel Ecm::Products::ProductCategory.human_attribute_name(:long_description) do
      div { ecm_products_product_category.long_description }
    end

    panel Ecm::Products::ProductCategory.human_attribute_name(:ecm_products_products) do
      table_for ecm_products_product_category.ecm_products_products, :i18n => Ecm::Products::Product do
        sortable_columns
        column :preview_image do |p|
          link_to(image_tag(p.preview_image.url(:medium_thumb)), [:admin, p])
        end
        column :name
        column :short_description
        column :created_at
        column :updated_at
        column do |p|
          link_to(I18n.t('active_admin.view'), admin_ecm_products_product_path(p), :class => "member_link view_link") +
          link_to(I18n.t('active_admin.edit'), edit_admin_ecm_products_product_path(p), :class => "member_link edit_link")
        end
      end
    end
  end # show

  sidebar Ecm::Products::ProductCategory.human_attribute_name(:details), :only => :show do
    div { image_tag(ecm_products_product_category.preview_image.url(:medium_thumb)) }
    attributes_table_for ecm_products_product_category do
      row :parent
      row :name
      row :ecm_products_products_count
      row :markup_language
      row :created_at
      row :updated_at
    end
  end # sidebar
end if defined?(::ActiveAdmin)

