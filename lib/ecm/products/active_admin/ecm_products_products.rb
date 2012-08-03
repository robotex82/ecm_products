::ActiveAdmin.register Ecm::Products::Product do
  # menu entry settings
  menu :parent => Proc.new { I18n.t('ecm.products.active_admin.menu') }.call
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :ecm_products_product_category
      f.input :locale, :as => :select, :collection => I18n.available_locales.map(&:to_s)
      f.input :name
      f.input :short_description
      f.input :long_description
      f.input :price
      f.input :price_on_application
      f.input :published_at
      f.input :preview_image, :as => :file
      f.input :main_image, :as => :file      
    end
    f.actions
  end
end if defined?(::ActiveAdmin)
