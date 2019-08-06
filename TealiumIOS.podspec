#
# Be sure to run `pod lib lint TealiumIOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.author           = { "Jonathan Wong" => "jonathan.wong@tealium.com" }
    s.homepage         = "https://github.com/tealium/tealium-ios"
    s.documentation_url = 'http://tealium.github.io/tealium-ios/'
    s.frameworks = 'SystemConfiguration'
    s.license      = { :type => "Commercial", :file => "LICENSE.txt" }
    s.name             = "TealiumIOS"
    s.version          = "5.5.5"
    s.requires_arc = true
    s.social_media_url   = "https://twitter.com/tealium"
    s.source           = { :git => "https://github.com/tealium/tealium-ios.git", :tag => s.version.to_s }
    s.summary          = "Framework for adding Tealium services to an iOS application."
    s.platform     = :ios, '8.0'
    #s.public_header_files = 'TealiumIOS.framework/Headers/*.{h}'
    s.vendored_frameworks = 'TealiumIOS.framework'
    s.xcconfig = {'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/TealiumIOS/TealiumIOS'}
end
