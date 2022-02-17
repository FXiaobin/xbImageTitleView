
Pod::Spec.new do |spec|

 
  spec.swift_version = "5.0"

  spec.name         = "xbImageTitleView"
  spec.version      = "0.0.5"
  spec.summary      = "xbImageTitleView."
 spec.description  = <<-DESC
类似UIButton的自定义控件，可设置图片和title上下左右位置和它们之间的间距
                   DESC

  spec.requires_arc = true
  spec.license      = "MIT"
  spec.author             = { "FXiaobin" => "527256662@qq.com" } 
  spec.platform     = :ios, "9.0"
 
  spec.homepage     = "https://github.com/FXiaobin/xbImageTitleView"
  spec.source       = { :git => "https://github.com/FXiaobin/xbImageTitleView.git", :tag => "#{spec.version}" }

  spec.source_files  = "xbImageTitleView", "xbImageTitleView/*.{swift}"

  

  spec.dependency "SnapKit"

end
