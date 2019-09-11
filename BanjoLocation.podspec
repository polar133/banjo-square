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

  s.static_framework = true # <- Google Maps
  s.swift_version = '5.0'
  s.ios.deployment_target = '12.0'

  s.subspec 'Core' do |sp|
    sp.source_files = 'BanjoLocation/Classes/Core/**/*.{swift}'
    sp.resources =  'BanjoLocation/Assets/Core/**/*.{strings,xib,xcassets,json,ttf,plist,imageset,png}'
  end

  s.subspec 'Dashboard' do |sp|
    sp.dependency 'BanjoLocation/Core'
    sp.source_files = 'BanjoLocation/Classes/Dashboard/**/*.{swift}'
    sp.resources =    'BanjoLocation/Assets/Dashboard/**/*.{strings,xib,xcassets,json,ttf,plist,imageset,png}'
    sp.test_spec 'Dashboard-UnitTests' do |test_spec|
      test_spec.dependency 'OHHTTPStubs/Swift','>= 6.1.0'
      test_spec.resources = 'BanjoLocation/Tests/DashboardTests/Resources/*.{strings,json}'
      test_spec.source_files = 'BanjoLocation/Tests/DashboardTests/**/*.{swift}'
    end

    #External dependencies
    sp.dependency 'GoogleMaps', '>= 3.4.0'
    sp.dependency 'GooglePlaces', '>= 3.4.0'
  end


end
