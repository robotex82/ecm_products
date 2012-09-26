Ecm::Products.configure do |config|
  # markup options

  # Accepted markup languages
  config.markup_languages = %w[ markdown rdoc textile ]

  # Default markup language
  config.default_markup_language = 'textile'

  # product category options

  # image sizes for product category preview images
  config.product_category_preview_image_styles = {
    :small_thumb => "64x48",
    :medium_thumb => "160x120",
    :big_thumb => "360x268"
  }

  # image sizes for product category main images
  config.product_category_main_image_styles = {
    :medium_thumb => "160x120",
    :big_thumb => "360x268"
  }

  # product options

  # image sizes for product preview images
  config.product_preview_image_styles = {
    :medium_thumb => "160x120",
    :big_thumb    => "360x268"
  }

  # image sizes for product main images
  config.product_main_image_styles = {
    :medium_thumb => "160x120",
    :big_thumb    => "360x268"
  }

  # product picture options

  # image sizes for slider items
  config.product_picture_image_styles = {
    :small_thumb  => "80x60>",
    :medium_thumb => "160x120>",
    :default      => "260x180"
  }
end

