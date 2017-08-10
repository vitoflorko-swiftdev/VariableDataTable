Pod::Spec.new do |s|
  s.name             = 'VariableDataTable'
  s.version          = '0.3'
  s.summary          = 'Variable Data Table for iOS + Swift 3'
 
  s.description      = <<-DESC
Horizontal or vertical customizable table for iOS apps with a singular purpose: to easily and effectively display data!
                       DESC
 
  s.homepage         = 'https://github.com/vitoflorko-swiftdev/VariableDataTable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vito Florco' => 'vitoflorko@icloud.com' }
  s.source           = { :git => 'https://github.com/vitoflorko-swiftdev/VariableDataTable.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'VariableDataTable/VDTable.swift'
 
end
