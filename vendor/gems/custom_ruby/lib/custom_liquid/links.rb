module CustomLiquid
  module Links
    def external_link(caption, url)
      %(<a href="#{url}" target="_blank" rel="noopener">#{caption}</a>)
    end
  end
end
