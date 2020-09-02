module CustomLiquid
  module ImageLightboxFilter
      def lightbox_image(image_url)
        %(<a href="#{image_url}"><img src="#{image_url}" /></a>)
      end
  end
end
