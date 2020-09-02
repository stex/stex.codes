require "custom_liquid/version"
require "custom_liquid/image_lightbox_filter"

module CustomLiquid
  class Error < StandardError; end
end

Liquid::Template.register_filter(CustomLiquid::ImageLightboxFilter)
