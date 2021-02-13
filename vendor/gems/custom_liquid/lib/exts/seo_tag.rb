Jekyll::SeoTag.instance_eval do
  def template_path
    File.expand_path("./seo_template.html", __dir__)
  end
end
