platform :ios, '15.0'

def common
pod 'Moya', '~> 15.0'
pod 'Resolver'
end

def ui
pod 'SDWebImage', '~> 5.0'
end

target 'Arty' do
use_frameworks!

common
ui

target 'ArtyTests' do
inherit! :search_paths
# Pods for testing
end

target 'ArtyUITests' do
# Pods for testing
end

end

target 'ArtyData' do
use_frameworks!

common

target 'ArtyDataTests' do
# Pods for testing
end

end
