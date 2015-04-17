Pod::Spec.new do |s|
  s.name             = "Backo"
  s.version          = "0.1.0"
  s.summary          = "Exponential Backoff for objective-c."
  s.description      = <<-DESC
                       Backo implements the exponential backoff algorithm described
                       in [this article](http://www.awsarchitectureblog.com/2015/03/backoff.html).
                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/segmentio/backo-objective-c"
  s.license          = 'MIT'
  s.author           = { "Segment" => "engineering@segment.com" }
  s.source           = { :git => "https://github.com/segmentio/backo-objective-c.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/segment'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Backo/Classes/**/*'

end