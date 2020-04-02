#
# Be sure to run `pod lib lint QYTheme.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QYTheme'
  s.version          = '1.0.0'
  s.summary          = 'iOS13 Dark Mode.'
  s.description      = 'Adapt to iOS13 Dark Mode.'
  s.homepage         = 'https://github.com/qiaoyoung/QYTheme'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'qiaoyoung' => '393098486@qq.com' }
  s.source           = { :git => 'https://github.com/qiaoyoung/QYTheme.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source_files = 'QYTheme/**/*'
  s.dependency 'SDWebImage'

  # s.resource_bundles = {
  #   'QYTheme' => ['QYTheme/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
 
end
