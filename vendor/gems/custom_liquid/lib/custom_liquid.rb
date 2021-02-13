require "custom_liquid/version"
require "custom_liquid/image_lightbox_filter"
require "custom_liquid/thumbor"
require "custom_liquid/assets"
require "custom_liquid/links"

require "exts/seo_tag"

module CustomLiquid
  class Error < StandardError; end
end

Liquid::Template.register_filter(CustomLiquid::ImageLightboxFilter)
Liquid::Template.register_filter(CustomLiquid::Thumbor)
Liquid::Template.register_filter(CustomLiquid::Assets)
Liquid::Template.register_filter(CustomLiquid::Links)
