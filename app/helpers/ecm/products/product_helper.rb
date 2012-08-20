module Ecm::Products::ProductHelper
  def render_product(name)
    product = Ecm::Products::Product.where(:name => name).first
    
    output = ''
    
    unless product.nil?
      output << render(:partial => 'ecm/products/products/product_preview', :locals => { :product => product, :product_counter => 0 })
      output << tag(:hr)
    end  
    
    output << link_to(product.ecm_products_product_category, :class => 'btn list-link') do
      content_tag(:i, "", :class => 'icon-list') + " " + 
      product.ecm_products_product_category
    end
    return output.html_safe    
  end
end  
