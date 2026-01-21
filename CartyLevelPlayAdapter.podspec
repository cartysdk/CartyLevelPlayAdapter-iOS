Pod::Spec.new do |spec|
  spec.name         = "CartyLevelPlayAdapter"
  spec.version      = "1.0.0"
  spec.summary      = "CartyLevelPlayAdapter"
  spec.description  = <<-DESC
             CartyLevelPlayAdapter for iOS. 
                   DESC
  spec.homepage     = "https://github.com/cartysdk/CartyLevelPlayAdapter-iOS"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "carty" => "ssp_tech@carty.io" } 
  spec.source       = { :git => "https://github.com/cartysdk/CartyLevelPlayAdapter-iOS.git", :tag => spec.version }
  spec.platform     = :ios, '13.0'
  spec.ios.deployment_target = '13.0'
  spec.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC'
  }
  spec.source_files = 'CartyLevelPlayAdapter/*.{h,m}'
  spec.static_framework = true

  spec.dependency 'CartySDK'
  spec.dependency 'IronSourceSDK'
end