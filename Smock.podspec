Pod::Spec.new do |s|
  s.name             = 'Smock'
  s.version          = '0.2.0'
  s.summary          = 'Makes mocking in Swift easier'

  s.description      = <<-DESC
Smock makes testing protocol extensions in Swift easier by providing capability to record selector calls, parameters and stub return values
                       DESC

  s.homepage         = 'https://github.com/kviksilver/Smock'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kviksilver' => 'berceg@gmail.com' }
  s.source           = { :git => 'https://github.com/kviksilver/Smock.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kviksilver'

  s.ios.deployment_target = '9.0'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '3.0'

  s.source_files = 'Sources/**/*'
  s.frameworks = 'XCTest', 'Foundation'
end
