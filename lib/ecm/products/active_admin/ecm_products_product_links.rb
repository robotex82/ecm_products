::ActiveAdmin.register Ecm::Products::ProductLink do
  # menu entry settings
  menu :parent => Proc.new { I18n.t('ecm.products.active_admin.menu') }.call
  
  form do |f|
    f.inputs do
      f.input :ecm_products_product
      f.input :name
      f.input :url
      f.input :description  
    end
    f.actions
  end  
end if defined?(::ActiveAdmin)
