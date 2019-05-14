#
# Be sure to run `pod lib lint ALSimplePriorityQueue.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ALSimplePriorityQueue'
  s.version          = '0.1.8'
  s.summary          = 'A short description of ALSimplePriorityQueue.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A class represents super simple idea of PriorityQueue. Doesnt contain a super performant
algorithm
                       DESC

  s.homepage         = 'https://github.com/AlexHmelevski/ALSimplePriorityQueue'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AlexHmelevskiAG' => 'alexei.hmelevski@gmail.com' }
  s.source           = { :git => 'https://github.com/AlexHmelevski/ALSimplePriorityQueue.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'ALSimplePriorityQueue/Classes/**/*'
end
