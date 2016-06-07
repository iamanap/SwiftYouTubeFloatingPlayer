//
//  CustomSlider.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 5/25/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    func setup() {
        self.maximumTrackTintColor = UIColor.clearColor()
        self.continuous = true
    }
    
    override func trackRectForBounds(bounds: CGRect) -> CGRect {
        var newBounds = super.trackRectForBounds(bounds)
        newBounds.size.height = 6
        return newBounds
    }
}

class CustomProgress: UIProgressView {
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = 2.0
        self.clipsToBounds = true
        self.transform = CGAffineTransformScale(self.transform, 1, 3)
    }

}