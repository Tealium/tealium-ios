#
# Be sure to run `pod lib lint TealiumIOSLifecycle.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.author           = { "Craig Rouse" => "craig.rouse@tealium.com" }
    s.homepage         = "https://github.com/tealium/"
    s.documentation_url = 'http://tealium.github.io/tealium-ios/'
    s.frameworks = 'SystemConfiguration'
    s.license      = { :type => "Commercial", :file => "LICENSE.txt" }
    s.name             = "TealiumIOSLifecycle"
    s.version          = "5.8.3"
    s.requires_arc = true
    s.social_media_url   = "https://twitter.com/tealium"
    s.source           = { :git => "https://github.com/tealium/tealium-ios.git", :tag => s.version.to_s}
    s.summary          = "A companion framework to TealiumIOS that adds Lifecycle tracking to an iOS application."
    s.platform     = :ios, '8.0'
    #s.public_header_files = 'TealiumIOS.framework/Headers/*.{h}'
    s.vendored_frameworks = 'TealiumIOSLifecycle.xcframework'
    s.xcconfig = {'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Headers/Public/TealiumIOS_Lifecycle/'}
    # Workaround to exclude arm64 from simulator. If you are on an M1 Mac, please use the XCFrameworks
    # that are uploaded to the latest release
    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
end
