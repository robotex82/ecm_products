module Ecm
  module Products
    class Routing
      # Creates the routes for products and categories. You can pass options to
      # specify the actions for both products and/or categories.
      #
      #   Ecm::Products::Routing.routes(self, { :product_category_actions => [ :show ]})
      #
      # This will only create the show action for product categories, but omit the index action.
      def self.routes(router, options = {})
        options.reverse_merge!(
          { :product_category_actions => [:index, :show], 
            :product_actions => [:index, :show] 
          }
        )
        
        router.resources :ecm_products_product_categories, :only => options[:product_category_actions], :controller => 'ecm/products/product_categories'
        router.resources :ecm_products_products,:only => options[:product_actions], :controller => 'ecm/products/products'      
      end  
    end
  end
end    
