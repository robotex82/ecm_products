namespace :ecm do
  namespace :products do
    namespace :db do
      desc "Purges and creates example data"
      task :populate!, [] => [:environment] do |t, args|

        Rake::Task["ecm:products:db:clear!"].execute
        Rake::Task["ecm:products:db:populate"].execute
      end

      desc "Clears all data!"
      task :clear!, [] => [:environment] do |t, args|
        Rake::Task["ecm:products:db:clear_product_categories!"].execute
        Rake::Task["ecm:products:db:clear_products!"].execute
        Rake::Task["ecm:products:db:clear_product_links!"].execute
        Rake::Task["ecm:products:db:clear_product_pictures!"].execute
      end

      desc "Clears all product categories!"
      task :clear_product_categories!, [] => [:environment] do |t, args|
        Ecm::Products::ProductCategory.delete_all
      end

      desc "Clears all products!"
      task :clear_products!, [] => [:environment] do |t, args|
        Ecm::Products::Product.delete_all
      end

      desc "Clears all product links!"
      task :clear_product_links!, [] => [:environment] do |t, args|
        Ecm::Products::ProductLink.delete_all
      end

      desc "Clears all product pictures!"
      task :clear_product_pictures!, [] => [:environment] do |t, args|
        Ecm::Products::ProductPicture.delete_all
      end

      desc "Creates example data"
      task :populate, [] => [:environment] do |t, args|
        Rake::Task["ecm:products:db:populate_product_categories"].execute
        Rake::Task["ecm:products:db:populate_products"].execute
        Rake::Task["ecm:products:db:populate_product_links"].execute
        Rake::Task["ecm:products:db:populate_product_pictures"].execute
      end

      desc "Creates example for product categories"
      task :populate_product_categories, [] => [:environment] do |t, args|
        require "ffaker"
        require "forgery"

        # Create example product category roots
        5.times do
          Ecm::Products::ProductCategory.create! do |pc|
            pc.locale            = I18n.available_locales.choice.to_s
            pc.name              = "#{Faker::Product.brand} #{(1 + rand(9))}"
            pc.short_description = Faker::Lorem.paragraph(2)
            pc.long_description  = Faker::Lorem.paragraph(10)
            pc.preview_image     = File.open(ECM::Products::Engine.root + "spec/files/ecm/products/product/preview_image.gif")
            pc.main_image        = File.open(ECM::Products::Engine.root + "spec/files/ecm/products/product/main_image.gif")
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
            pc.preview_image     = File.open(ECM::Products::Engine.root + "spec/files/ecm/products/product_category/preview_image.gif")
            pc.main_image        = File.open(ECM::Products::Engine.root + "spec/files/ecm/products/product_category/main_image.gif")
          end
        end
      end

      desc "Creates example for products"
      task :populate_products, [] => [:environment] do |t, args|
        # Create example products
        product_categories = Ecm::Products::ProductCategory.all
        50.times do
          Ecm::Products::Product.create! do |p|
            p.name                 = Faker::Product.product_name
            p.short_description    = Faker::Lorem.paragraph(rand(2))
            p.long_description     = Faker::Lorem.paragraph(rand(10))
            p.price_on_application = [true, false].choice
            p.preview_image        = File.open(ECM::Products::Engine.root + "spec/files/ecm/products/product_category/preview_image.gif")
            p.main_image           = File.open(ECM::Products::Engine.root + "spec/files/ecm/products/product_category/main_image.gif")

            p.ecm_products_product_category = product_categories.choice

            p.price = Money.new(rand(1000000 / 100), "EUR")
          end
        end
      end

      desc "Creates example for product links"
      task :populate_product_links, [] => [:environment] do |t, args|
        # Create example links
        Ecm::Products::Product.all.each do |p|
          rand(10).times do
            p.ecm_products_product_links.create! do |pl|
              pl.name        = Faker::Product.product_name
              pl.url         = Faker::Internet.http_url
              pl.description = Faker::Lorem.paragraph(rand(3))
            end
          end
        end
      end

      desc "Creates example for products"
      task :populate_product_pictures, [] => [:environment] do |t, args|
        # Create example pictures
        Ecm::Products::Product.all.each do |p|
          (0..10).to_a.push(0, 0, 0, 0, 0).choice.times do
            p.ecm_products_product_pictures.create! do |pp|
              pp.image       = File.open(ECM::Products::Engine.root + "spec/files/ecm/products/product_picture/image.jpg")
              pp.description = Faker::Lorem.paragraph(rand(3)) if rand(2) > 0
            end
          end
        end
      end
    end
  end
end

