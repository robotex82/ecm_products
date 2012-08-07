namespace :ecm_products do
  namespace :db do
    desc "Purges and creates example data"
    task :populate!, [] => [:environment] do |t, args|
      Ecm::Products::ProductCategory.delete_all
      Ecm::Products::Product.delete_all
      Ecm::Products::ProductLink.delete_all
      Rake::Task["ecm_products:db:populate"].execute
    end
    
    desc "Creates example_data"
    task :populate, [] => [:environment] do |t, args|
      require "ffaker"
      require "forgery"

      # Create example product category roots
      10.times do
        Ecm::Products::ProductCategory.create! do |pc|
          pc.locale            = I18n.available_locales.choice.to_s      
          pc.name              = Faker::Product.brand
          pc.short_description = Faker::Lorem.paragraph(2)
          pc.long_description  = Faker::Lorem.paragraph(10)   
          pc.preview_image     = File.open(Rails.root + "spec/fixtures/product/preview_image.gif")
          pc.main_image        = File.open(Rails.root + "spec/fixtures/product/main_image.gif")     
        end
      end
      
      # Create example product categories
      # roots = Ecm::Products::ProductCategory.roots.all
      10.times do
        Ecm::Products::ProductCategory.create! do |pc|
          pc.parent            = Ecm::Products::ProductCategory.all.choice
          pc.name              = Faker::Product.brand
          pc.short_description = Faker::Lorem.paragraph(2)
          pc.long_description  = Faker::Lorem.paragraph(10) 
          pc.preview_image     = File.open(Rails.root + "spec/fixtures/product_category/preview_image.gif")
          pc.main_image        = File.open(Rails.root + "spec/fixtures/product_category/main_image.gif")           
        end
      end      
      
      # Create example products
      product_categories = Ecm::Products::ProductCategory.all
      100.times do
        Ecm::Products::Product.create! do |p|
          p.locale               = I18n.available_locales.choice.to_s 
          p.name                 = Faker::Product.product_name
          p.short_description    = Faker::Lorem.paragraph(rand(2))
          p.long_description     = Faker::Lorem.paragraph(rand(10))   
          p.price_on_application = [true, false].choice     
          p.preview_image        = File.open(Rails.root + "spec/fixtures/product_category/preview_image.gif")
          p.main_image           = File.open(Rails.root + "spec/fixtures/product_category/main_image.gif")    
          
          p.ecm_products_product_category = product_categories.choice
          
          p.price Money.new(rand(1000000 / 100), "EUR")
        end
      end        
      
      # Create example links    
      Ecm::Products::Product.all.each do |p|
        rand(10).times do
          p.ecm_products_product_links.create do |pl|
            pl.name        = Faker::Product.product_name
            pl.url         = Faker::Internet.http_url
            pl.description = Faker::Lorem.paragraph(rand(3))
          end
        end
      end  
    end  
  end
end
