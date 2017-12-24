
target 'gitparser' do
    platform :ios, '9.0'
    use_frameworks!
    
    pod 'Moya/ReactiveSwift', '~> 8.0.3'
    pod 'ReactiveCocoa', '~> 5.0.3'
    pod 'ReactiveSwift', '~> 1.1.3'
    pod 'AlamofireImage', '~> 3.3'
    pod 'MBProgressHUD'
end

post_install do |installer|
    # list of targets only compatible with Swift 3.2
    myTargets = ['ReactiveCocoa', 'ReactiveSwift', 'Result', 'Moya']
    
    installer.pods_project.targets.each do |target|
        if myTargets.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end
