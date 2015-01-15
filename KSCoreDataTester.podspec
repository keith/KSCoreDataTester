Pod::Spec.new do |s|
  s.name                  = "KSCoreDataTester"
  s.version               = "1.0.0"
  s.summary               = "Core Data categories for easy testing with in memory stores"
  s.homepage              = "https://github.com/Keithbsmiley/KSCoreDataTester"
  s.license               = "MIT"
  s.author                = { "Keith Smiley" => "keithbsmiley@gmail.com" }
  s.social_media_url      = "http://twitter.com/SmileyKeith"
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.9"
  s.source                = { git: "https://github.com/Keithbsmiley/KSCoreDataTester.git",
                              tag: "v#{ s.version }" }
  s.source_files          = "*.{h,m}"
  s.public_header_files   = "KSCoreDataTester.h"
  s.framework             = "CoreData"
  s.requires_arc          = true
end
