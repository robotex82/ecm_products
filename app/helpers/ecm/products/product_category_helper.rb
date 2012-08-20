module Ecm::Products::ProductCategoryHelper
  def render_product_category(name)
    category = Ecm::Products::ProductCategory.where(:locale => I18n.locale.to_s).where(:name => name).first
    
    output = ''
    
    unless category.nil?
      output << render(:partial => 'ecm/products/product_categories/product_category_preview', :locals => { :product_category => category})
      output << tag(:hr)
    end  
    
    output << link_to(ecm_products_product_categories_path, :class => 'btn list-link') do
      content_tag(:i, "", :class => 'icon-list') + " " + 
      I18n.t('ecm.products.product_category.actions.all')
    end
    return output.html_safe    
  end
end  
