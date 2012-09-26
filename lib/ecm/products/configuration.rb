require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Ecm
  module Products
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :markup_languages
      @@markup_languages = []

      mattr_accessor :default_markup_language
      @@default_markup_language = nil

      mattr_accessor :product_category_preview_image_styles
      @@product_category_preview_image_styles = {}
      def product_category_preview_image_styles=(product_category_preview_image_styles)
        @@product_category_preview_image_styles = HashWithIndifferentAccess.new(product_category_preview_image_styles)
      end

      mattr_accessor :product_category_main_image_styles
      @@product_category_main_image_styles = {}
      def product_category_main_image_styles=(product_category_main_image_styles)
        @@product_category_main_image_styles = HashWithIndifferentAccess.new(product_category_main_image_styles)
      end

      mattr_accessor :product_preview_image_styles
      @@product_preview_image_styles = {}
      def product_preview_image_styles=(product_preview_image_styles)
        @@product_preview_image_styles = HashWithIndifferentAccess.new(product_preview_image_styles)
      end

      mattr_accessor :product_main_image_styles
      @@product_main_image_styles = {}
      def product_main_image_styles=(product_main_image_styles)
        @@product_main_image_styles = HashWithIndifferentAccess.new(product_main_image_styles)
      end

      mattr_accessor :product_picture_image_styles
      @@product_picture_image_styles = {}
      def product_picture_image_styles=(product_picture_image_styles)
        @@product_picture_image_styles = HashWithIndifferentAccess.new(product_picture_image_styles)
      end
    end
  end
end
