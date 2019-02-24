#
# Be sure to run `pod lib lint SDLoopingVideoView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SDLoopingVideoView'
  s.version          = '1.0.0'
  s.summary          = 'An automatically scaling and looping video-view based off of AVPlayerLayer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SDLoopingVideoView is a looping video-view based off of AVPlayerLayer; it works great when used as a video background (see below for list of apps using SDLoopingVideoView). SDLoopingVideoView automatically scales any video displayed to aspect-fill the view you define; scaling can be set manually as well. SDLoopingVideoView responds to any UIView animations and scales accordingly without interuption of the video playing.
                       DESC

  s.homepage         = 'https://github.com/SolsmaHawk/SDLoopingVideoView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'SDLoopingVideoViewExample/LICENSE' }
  s.author           = { 'SolsmaHawk' => 'solsma@me.com' }
  s.source           = { :git => 'https://github.com/SolsmaHawk/SDLoopingVideoView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'
  s.source_files = 'SDLoopingVideoView/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'SDLoopingVideoView' => ['SDLoopingVideoView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
