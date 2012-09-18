module Ecm
  module Products
    module Generators
      class LocalesGenerator < Rails::Generators::Base
        desc "Copies the locale files to your application"

        source_root File.expand_path('../../../../../../config/locales', __FILE__)

        def generate_locales
          copy_file "ecm.products.en.yml", "config/locales/ecm.products.en.yml"
          copy_file "ecm.products.de.yml", "config/locales/ecm.products.de.yml"

          copy_file "ecm.products.routes.en.yml", "config/locales/ecm.products.routes.en.yml"
          copy_file "ecm.products.routes.de.yml", "config/locales/ecm.products.routes.de.yml"

          copy_file "ecm.products.product.en.yml", "config/locales/ecm.products.product.en.yml"
          copy_file "ecm.products.product.de.yml", "config/locales/ecm.products.product.de.yml"

          copy_file "ecm.products.product_category.en.yml", "config/locales/ecm.products.product_category.en.yml"
          copy_file "ecm.products.product_category.de.yml", "config/locales/ecm.products.product_category.de.yml"

          copy_file "ecm.products.product_link.en.yml", "config/locales/ecm.products.product_link.en.yml"
          copy_file "ecm.products.product_link.de.yml", "config/locales/ecm.products.product_link.de.yml"
        end
      end
    end
  end
end

