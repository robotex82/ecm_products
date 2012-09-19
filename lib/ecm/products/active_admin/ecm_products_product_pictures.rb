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

  show do
    panel Ecm::Products::ProductPicture.human_attribute_name(:image) do
      div { image_tag(ecm_products_product_picture.image.url) }
    end

    attributes_table do
      row :name
      row :markup_language
      row :image_file_name
      row :image_file_size do |pp|
        number_to_human_size(pp.image_file_size)
      end
      row :image_content_type
      row :image_updated_at
      row :image_fingerprint     
      row :created_at
      row :updated_at 
    end

    panel Ecm::Products::ProductPicture.human_attribute_name(:description) do
      div { ecm_products_product_picture.description }
    end
  end # show

  sidebar Ecm::Products::ProductPicture.human_attribute_name(:ecm_products_product), :only => :show do
    div { image_tag(ecm_products_product_picture.ecm_products_product.preview_image.url(:medium_thumb)) }
    attributes_table_for ecm_products_product_picture.ecm_products_product do
      row(:name) { |p| link_to(p.name, [:admin, p]) }
      row :ecm_products_product_category
      row(:price) { |p| humanized_money_with_symbol p.price }
      row(:price_on_application) { |p| I18n.t(p.price_on_application) }
      row :published_at
      row :markup_language
      row :created_at
      row :updated_at
    end
  end # sidebar
end if defined?(::ActiveAdmin)

