Pod::Spec.new do |s|
  s.name                = "GetLocation"
  s.version             = "0.0.3"
  s.summary             = "Utility library for easily getting the location of a user"
  s.license             = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage            = "https://ajayjapan.com"
  s.author              = { "Ajay Chainani" => "hello@ajayjapan.com" }
  s.source              = { :git => "https://github.com/achainan/OneTimeLocationUpdate.git", :tag => "v0.0.1"}
  s.source_files        = 'GetLocation/*.{h,m}'
  s.public_header_files = 'GetLocation/*.h'
  s.platform            = :ios
  s.requires_arc        = true
end