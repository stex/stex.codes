require "ruby-thumbor"

module CustomLiquid
  module Thumbor
    THUMBOR_URL = ENV.fetch("THUMBOR_URL", nil)
    THUMBOR_SECURITY_KEY = ENV.fetch("THUMBOR_SECURITY_KEY", nil)

    def thumbor_url(image_url, width = "950")
      return image_url unless thumbor?
      image_url = image_url.sub("0.0.0.0", "localhost") if Jekyll.env == "development"

      THUMBOR_URL + ::Thumbor::Cascade.new(THUMBOR_SECURITY_KEY, image_url).tap { |image|
        image.width(width)
      }.generate
    end

    private

    def thumbor?
      THUMBOR_URL && THUMBOR_SECURITY_KEY
    end
  end
end
