#
# Be sure to run `pod lib lint BanjoLocation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BanjoLocation'
  s.version          = '0.1.0'
  s.summary          = 'Framework for BanjoLocation. Map and detail of venues'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Using the Foursquare API, this will show a map with with the venues around the user's location. MVP Architecture. Unit tests as testspecs
  DESC

  s.homepage         = 'https://github.com/polar133/banjo-square'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Carlos Jimenez' => 'cjimenez02@gmail.com' }
  s.source           = { :git => 'git@github.com:polar133/banjo-square.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/carlos_polar'

  s.ios.deployment_target = '12.0'

  s.source_files = 'BanjoLocation/Classes/**/*'

end
