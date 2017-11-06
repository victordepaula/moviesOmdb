# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Zup' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    # Pods for Zup
    pod 'Alamofire', '~> 4.5'
    
    pod 'AlamofireObjectMapper', :git => 'https://github.com/tristanhimmelman/AlamofireObjectMapper.git',
    :branch => 'swift-4'
    pod 'ObjectMapper', '~> 3.0'
    
    pod 'SDWebImage', '~>4.0'
    pod 'ScalingCarousel'
    pod 'NVActivityIndicatorView'

    target 'ZupTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
    target 'ZupUITests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end

