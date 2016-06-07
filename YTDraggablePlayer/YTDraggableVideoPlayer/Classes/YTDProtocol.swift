//
//  YTDProtocol.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 6/6/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit

protocol YTDProtocol { }

extension YTDProtocol {
    
    func initYTD(url: NSURL) {
        dragViewController?.setURLs([url])
    }
    
    func initYTD(urls: [NSURL]) {
        dragViewController?.setURLs(urls)
    }
    
    func changeURL(url: NSURL) {
        dragViewController?.setPlayerURLs([url])
    }
    
    func changeURL(url: [NSURL]) {
        dragViewController?.setPlayerURLs(url)
    }
    
    func showYTDViewController(viewController: UIViewController) {
        dragViewController!.view.frame = CGRectMake(viewController.view.frame.size.width-50, viewController.view.frame.size.height-50, viewController.view.frame.size.width, viewController.view.frame.size.height)
        dragViewController!.initialFirstViewFrame = viewController.view.frame
        dragViewController!.view.alpha = 0
        dragViewController!.view.transform = CGAffineTransformMakeScale(0.2, 0.2)
        dragViewController!.onView = viewController.view
        
        UIApplication.sharedApplication().keyWindow?.addSubview(dragViewController!.view)
        
        UIView.animateWithDuration(0.5, animations: {
            dragViewController!.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            dragViewController!.view.alpha = 1
            dragViewController!.view.frame = CGRectMake(viewController.view.frame.origin.x, viewController.view.frame.origin.y, viewController.view.frame.size.width, viewController.view.frame.size.height)
        })
    }
}

var dragViewController: YTDViewController? = YTDViewController(nibName: "YTDViewController", bundle: nil)