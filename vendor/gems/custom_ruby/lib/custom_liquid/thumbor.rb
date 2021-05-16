require "ruby-thumbor"

module CustomLiquid
  module Thumbor
    THUMBOR_URL = ENV.fetch("THUMBOR_URL", nil)
    THUMBOR_SECURITY_KEY = ENV.fetch("THUMBOR_SECURITY_KEY", nil)

    def thumbor_url(url, width = "950", height = "0")
      return url unless thumbor?
      url = url.sub("0.0.0.0", "localhost") if Jekyll.env == "development"

      THUMBOR_URL + ::Thumbor::Cascade.new(THUMBOR_SECURITY_KEY, absolute_url(url)).tap { |image|
        image.width(width.to_i)
        image.height(height.to_i)
        image.smart
      }.generate
    end

    def thumbor_image_url(url, *args)
      thumbor_url(image_url(url), *args)
    end

    private

    def thumbor?
      THUMBOR_URL && THUMBOR_SECURITY_KEY
    end
  end
end
