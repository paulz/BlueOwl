platform :ios, '11.0'

def bdd_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'SwiftOwl' do
    use_frameworks!

    target 'UnitSpecs' do
        inherit! :search_paths
        bdd_pods
    end
end

target 'BlueOwl' do
    use_frameworks!

    target 'AppSpecs' do
        inherit! :search_paths
        bdd_pods
    end

    target 'UITests' do
        inherit! :search_paths
        bdd_pods
    end
end

