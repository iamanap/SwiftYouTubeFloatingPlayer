//
//  YTDProtocol.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 6/6/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit

protocol YTFProtocol { }

extension YTFProtocol {
    
    func initYTF(url: NSURL, tableCellNibName: String?, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        if (dragViewController != nil) {
            finishYTFView()
        }
        dragViewController = YTFViewController(nibName: "YTFViewController", bundle: nil)
        dragViewController?.urls = [url]
        dragViewController?.delegate = delegate
        dragViewController?.dataSource = dataSource
        if let tableCellNib = tableCellNibName {
            dragViewController?.tableCellNibName = tableCellNib
        } else {
            dragViewController?.tableCellNibName = "VideoCell"
        }
    }
    
    func initYTF(urls: [NSURL], tableCellNibName: String?, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        if (dragViewController != nil) {
            finishYTFView()
        }
        dragViewController = YTFViewController(nibName: "YTFViewController", bundle: nil)
        dragViewController?.urls = urls
        dragViewController?.delegate = delegate
        dragViewController?.dataSource = dataSource
        if let tableCellNib = tableCellNibName {
            dragViewController?.tableCellNibName = tableCellNib
        } else {
            dragViewController?.tableCellNibName = "VideoCell"
        }
    }
    
    func showYTFView(viewController: UIViewController) {
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
    
    func changeURL(url: NSURL) {
        dragViewController?.urls = [url]
    }
    
    func changeURLs(urls: [NSURL]) {
        dragViewController?.urls = urls
    }
    
    func playIndex(index: Int) {
        dragViewController?.currentUrlIndex = index
    }
    
    func finishYTFView() {
        dragViewController?.removeViews()
        dragViewController = nil
    }
}

var dragViewController: YTFViewController?