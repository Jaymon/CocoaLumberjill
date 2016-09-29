# http://guides.cocoapods.org/syntax/podspec.html
Pod::Spec.new do |s|
  s.name = 'CocoaLumberjill'
  s.version = '0.0.1'
  s.homepage = 'https://github.com/Jaymon/CocoaLumberjill'
  s.source = { :git => "https://github.com/Jaymon/CocoaLumberjill.git", :tag => s.version.to_s }
  s.platform = :ios, '9.0'
  s.license = 'BSD'
  s.summary = 'Light wrapper around CocoaLumberjack'
  s.author = { 'Jay Marcyes' => 'jay@marcyes.com' }
  s.description = ::IO.read(File.join(File.dirname(__FILE__), 'README.md'))
  s.source_files = 'CocoaLumberjill/*.{h,m}'
  s.requires_arc = true
  s.dependency 'CocoaLumberjack'
end
