module CustomLiquid
  module Assets
    def asset_url(path)
      absolute_url("/assets/#{path}")
    end

    def image_url(path)
      asset_url("images/#{path}")
    end
  end
end
