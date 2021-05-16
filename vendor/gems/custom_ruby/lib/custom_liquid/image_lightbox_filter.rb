module CustomLiquid
  module ImageLightboxFilter
    def lightbox_image(image_url, alt_text = nil)
      %(<a href="#{image_url}"><img src="#{image_url}" alt="#{alt_text}" /></a>)
    end
  end
end
