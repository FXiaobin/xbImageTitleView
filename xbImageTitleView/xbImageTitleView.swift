//
//  xbImageTitleView.swift
//  xbImageTitleView
//
//  Created by huadong on 2022/1/26.
//

import UIKit
import SnapKit

public enum xbImageTitleViewType {
    case xb_imageTop
    case xb_imageBottom
    case xb_imageLeft
    case xb_imageRight
}

public class xbImageTitleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
   
   
    
    var tapActionBlock: ((xbImageTitleView) -> Void)?
    
    private var type: xbImageTitleViewType = .xb_imageTop
    private var space: CGFloat = 0.0
    private var imageSize: CGSize = .zero
    
    
    private var titleNormal: String?
    private var imageNormal: String?
    
    private var titleSelected: String?
    private var imageSelected: String?
    
    private var titleColorNormal: UIColor = UIColor.black
    private var titleColorSelected: UIColor = UIColor.black
    
    private var titleFontNormal: UIFont?
    private var titleFontSelected: UIFont?
    
    public var isSelected: Bool = false {
        didSet {
            
            if isSelected {
                self.imageBtn.setImage(UIImage(named: self.imageSelected ?? ""), for: .normal)
                self.titleLabel.text = self.titleSelected
                self.titleLabel.textColor = self.titleColorSelected
                self.titleLabel.font = self.titleFontSelected
                
            }else{
                self.imageBtn.setImage(UIImage(named: self.imageNormal ?? ""), for: .normal)
                self.titleLabel.text = self.titleNormal
                self.titleLabel.textColor = self.titleColorNormal
                self.titleLabel.font = self.titleFontNormal
            }

            layoutSubviews()
        }
    }
    
    @objc fileprivate func tapAction(sender: xbImageTitleView) {
        if let block = self.tapActionBlock {
            block(self)
        }
    }
    
    public init(frame: CGRect, type: xbImageTitleViewType, space: CGFloat, imageSize: CGSize) {
        super.init(frame: frame)
        
        self.type = type
        self.space = space
        self.imageSize = imageSize
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.imageBtn)
        self.containerView.addSubview(self.titleLabel)
       
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setImageTitleView(image: String, title: String?, titleColor: UIColor, isSelected: Bool) {
       
        if isSelected {
            self.titleSelected = title
            self.imageSelected = image
            self.titleColorSelected = titleColor
            self.titleFontSelected = titleLabel.font
            
        }else{
            self.titleNormal = title
            self.imageNormal = image
            self.titleColorNormal = titleColor
            self.titleFontNormal = titleLabel.font
        }
        // 默认设置，只是保存各个状态下的数据，默认为不选中状态，选中不选中只需要设置isSelected属性即可
        //self.isSelected = false
        
        let isSel = self.isSelected
        self.isSelected = isSel
    }
    
    public func setImageTitleView(font: UIFont, isSelected: Bool) {
        if isSelected {
            self.titleFontSelected = font
        }else{
            self.titleFontNormal = font
        }
        let isSel = self.isSelected
        self.isSelected = isSel
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var imgSize = imageSize
        if imageSize == .zero {
            imgSize = CGSize(width: 30.0, height: 30.0)
        }
        
        var allWidth: CGFloat = 0.0
        var allHeight: CGFloat = 0.0
        
        var textH: CGFloat = 20.0
        var textW: CGFloat = 0.0
        if type == .xb_imageLeft || type == .xb_imageRight{
            textW = textSize(withText: titleLabel.text ?? "", attributes: [NSAttributedString.Key.font : titleLabel.font ?? UIFont.systemFont(ofSize: 14.0)], limitWidth: self.bounds.width).width
            allWidth += textW
            allWidth += space
            allWidth += imgSize.width
            
        }else{
            textH = textSize(withText: titleLabel.text ?? "", attributes: [NSAttributedString.Key.font : titleLabel.font ?? UIFont.systemFont(ofSize: 14.0)], limitWidth: self.bounds.width).height
            //debugPrint("---- textH = \(textH)")
            allHeight += textH
            allHeight += space
            allHeight += imgSize.height
        }
       
        
        switch type {
        case .xb_imageTop:
            
            self.containerView.snp_remakeConstraints { make  in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: self.bounds.size.width, height: allHeight))
            }
            
            self.imageBtn.snp_remakeConstraints({ make  in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                make.size.equalTo(imgSize)
            })
            
            self.titleLabel.snp_remakeConstraints({ make  in
                make.top.equalTo(self.imageBtn.snp_bottom).offset(space)
                make.centerX.equalToSuperview()
            })
            
        break
            
        case .xb_imageBottom:
            
            self.containerView.snp_remakeConstraints { make  in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: self.bounds.size.width, height: allHeight))
            }
            
            self.titleLabel.snp_remakeConstraints({ make  in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: self.bounds.size.width, height: textH))
            })
            
            self.imageBtn.snp_remakeConstraints({ make  in
                make.top.equalTo(self.titleLabel.snp_bottom).offset(space)
                make.centerX.equalToSuperview()
                make.size.equalTo(imgSize)
            })
            
        break
            
        case .xb_imageLeft:
            
            self.containerView.snp_remakeConstraints { make  in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: allWidth, height: self.bounds.size.height))
            }
            
            self.imageBtn.snp_remakeConstraints({ make  in
                make.left.equalToSuperview()
                make.centerY.equalToSuperview()
                make.size.equalTo(imgSize)
            })
            
            self.titleLabel.snp_remakeConstraints({ make  in
                make.left.equalTo(self.imageBtn.snp_right).offset(space)
                make.centerY.equalToSuperview()
            })
            
        break
            
        case .xb_imageRight:
            
            self.containerView.snp_remakeConstraints { make  in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: allWidth, height: self.bounds.size.height))
            }
            
            self.titleLabel.snp_remakeConstraints({ make  in
                make.left.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalTo(textW)
            })
            
            self.imageBtn.snp_remakeConstraints({ make  in
                make.left.equalTo(self.titleLabel.snp_right).offset(space)
                make.centerY.equalToSuperview()
                make.size.equalTo(imgSize)
            })
            
        break
        }
        
    }
    
    
    
    
    @objc fileprivate func btnAction(sender: UIButton) {
        
    }
    
    lazy var containerView: UIView = {
       let bgV = UIView()
        bgV.backgroundColor = UIColor.orange
        
        return bgV
    }()
    
    // 只用来显示图片
    lazy var imageBtn: UIButton = {
        let btn = UIButton(frame: CGRect.zero)
        btn.isUserInteractionEnabled = false
        
        return btn
    }()
    
    // 只用来显示标题
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        
        return label
    }()

}

extension xbImageTitleView {
    
    private func textSize(withText: String, attributes: [NSAttributedString.Key : Any], limitWidth: CGFloat) -> CGSize{
        let rect = withText.boundingRect(with: CGSize(width: limitWidth, height: 1000), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: attributes, context: nil)
        
        return rect.size
    }
}
