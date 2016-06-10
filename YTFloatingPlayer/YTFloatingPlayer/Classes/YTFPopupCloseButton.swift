//
//  YTDPopupCloseButton.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 5/26/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit

class YTFPopupCloseButton: UIButton {
    var effectView: UIVisualEffectView
    
    override init(frame: CGRect) {
        effectView = UIVisualEffectView.init(effect: UIBlurEffect(style: .ExtraLight))
        effectView.userInteractionEnabled = false
        super.init(frame: frame)
        initViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        effectView = UIVisualEffectView.init(effect: UIBlurEffect(style: .ExtraLight))
        effectView.userInteractionEnabled = false
        super.init(coder: aDecoder)
        initViews()
    }
    
    func initViews() {
        self.addSubview(effectView)
        let highlightEffectView: UIVisualEffectView = UIVisualEffectView.init(effect: UIVibrancyEffect(forBlurEffect: effectView.effect as! UIBlurEffect))
        highlightEffectView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        highlightEffectView.frame = effectView.contentView.bounds
        let highlightView = UIView.init(frame: highlightEffectView.contentView.bounds)
        highlightView.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        highlightView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        highlightView.alpha = 0
        highlightEffectView.contentView.addSubview(highlightView)
        effectView.contentView.addSubview(highlightEffectView)
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSizeMake(0, 0)
        self.layer.masksToBounds = false
        
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        self.setImage(UIImage(named: "NowPlayingCollapseChevronMask"), forState: .Normal)
        
        self.accessibilityLabel = "Close"

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sendSubviewToBack(effectView)
        
        let minSideSize: CGFloat = min(self.bounds.size.width, self.bounds.size.height)
        
        effectView.frame = self.bounds
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.rasterizationScale = UIScreen.mainScreen().nativeScale
        maskLayer.shouldRasterize = true
        
        let path: CGPathRef = CGPathCreateWithRoundedRect(self.bounds, minSideSize / 2, minSideSize / 2, nil)
        maskLayer.path = path
        
        effectView.layer.mask = maskLayer
        
        var imageFrame: CGRect = self.imageView!.frame
        imageFrame.origin.y = imageFrame.origin.y + 0.5
        self.imageView!.frame = imageFrame
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var superSize: CGSize = super.sizeThatFits(size)
        superSize.width = superSize.width + 14
        superSize.height = superSize.height + 2
        
        return superSize
    }
}
