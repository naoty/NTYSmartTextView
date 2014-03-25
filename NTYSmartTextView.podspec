Pod::Spec.new do |s|
  s.name             = "NTYSmartTextView"
  s.version          = "0.1.0"
  s.summary          = "NSTextView with smart features"
  s.description      = <<-DESC
                       NSTextView with following smart features
                       * Smart indent
                       * Soft tab
                       * Auto pair completion
                       DESC
  s.homepage         = "https://github.com/naoty/NTYSmartTextView"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = "MIT"
  s.author           = { "Naoto Kaneko" => "naoty.k@gmail.com" }
  s.source           = { git: "https://github.com/naoty/NTYSmartTextView", tag: s.version.to_s }
  s.social_media_url = "https://twitter.com/naoty_k"

  s.platform     = :osx
  s.requires_arc = true

  s.source_files = "Classes"
  s.resources = "Resources"
end
