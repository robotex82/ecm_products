include ActiveAdmin::ActsAsList::Helper if defined?(ActiveAdmin)

::ActiveAdmin.register Ecm::Products::Product do
  # menu entry settings
  menu :parent => Proc.new { I18n.t('ecm.products.active_admin.menu') }.call

  # acts as list
  sortable_member_actions

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :ecm_products_product_category
      f.input :name
      f.input :short_description
      f.input :long_description
      f.input :price
      f.input :price_on_application
      f.input :published_at
      f.input :preview_image, :as => :file
      f.input :main_image, :as => :file
    end

    f.inputs do
      f.input :markup_language, :as => :select, :collection => Ecm::Products::Configuration.markup_languages
    end

    f.inputs do
      f.has_many :ecm_products_product_pictures do |pp|
        if pp.object.persisted?
          pp.input :_destroy, :as => :boolean, :label => I18n.t('active_admin.delete')
        end

#        pp.inputs do
          pp.input :name
          pp.input :image, :as => :file, 
                           :hint => pp.template.image_tag(pp.object.image.url(:medium_thumb))
          pp.input :description
#        end

#        pp.inputs do
          pp.input :markup_language, :as => :select, :collection => Ecm::Products::ProductPicture::MARKUP_LANGUAGES
#        end
      end # f.has_many
    end

    f.actions
  end

  index do
    selectable_column
    column :preview_image do |p|
      link_to(image_tag(p.preview_image.url(:medium_thumb)), [:admin, p])
    end
    column :ecm_products_product_category
    column :name
    column :short_description
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    panel Ecm::Products::Product.human_attribute_name(:main_image) do
      div { image_tag(ecm_products_product.main_image.url) }
    end

    panel Ecm::Products::Product.human_attribute_name(:ecm_products_product_pictures) do
      table_for ecm_products_product.ecm_products_product_pictures, :i18n => Ecm::Products::ProductPicture do
        sortable_columns

        column :thumbnail do |pp|
          link_to(image_tag(pp.image.url(:medium_thumb)), [:admin, pp])
        end
        column :name
        column :description
        column :created_at
        column :updated_at

        column do |pp|
          link_to(I18n.t('active_admin.view'), [:admin, pp], :class => "member_link view_link") +
          link_to(I18n.t('active_admin.edit'), [:edit, :admin, pp], :class => "member_link edit_link")
        end
      end
    end

    panel Ecm::Products::Product.human_attribute_name(:ecm_products_product_links) do
      table_for ecm_products_product.ecm_products_product_links, :i18n => Ecm::Products::ProductLink do
        sortable_columns

        column :name
        column :description
        column :url
        column do |pl|
          link_to(I18n.t('active_admin.view'), admin_ecm_products_product_link_path(pl), :class => "member_link view_link") +
          link_to(I18n.t('active_admin.edit'), edit_admin_ecm_products_product_link_path(pl), :class => "member_link edit_link")
        end
      end
    end

    panel Ecm::Products::Product.human_attribute_name(:short_description) do
      div { ecm_products_product.short_description }
    end

    panel Ecm::Products::Product.human_attribute_name(:long_description) do
      div { ecm_products_product.long_description }
    end
  end

  sidebar Ecm::Products::Product.human_attribute_name(:details), :only => :show do
    div { image_tag(ecm_products_product.preview_image.url(:medium_thumb)) }
    attributes_table_for ecm_products_product do
      row :ecm_products_product_category
      row :name
      row(:price) { |p| humanized_money_with_symbol p.price }
      row(:price_on_application) { |p| I18n.t(p.price_on_application) }
      row :published_at
      row :markup_language
      row :created_at
      row :updated_at
    end
  end # sidebar
end if defined?(::ActiveAdmin)

