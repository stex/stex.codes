require 'html-proofer'

task :test do
  ENV["JEKYLL_ENV"] = "production"
  sh "bundle exec jekyll build"
  HTMLProofer.check_directory("./_site", assume_extension: true).run
end
