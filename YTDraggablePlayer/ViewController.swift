//
//  ViewController.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 5/19/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit


class ViewController: UIViewController, YTDProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        // Only allow Portrait
        return UIInterfaceOrientation.Portrait
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    

    @IBAction func touch(sender: AnyObject) {
        initYTD([NSURL(string: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")!, NSURL(string:"http://api.mymixtapez.vuziqsrv.com/Album/Sv?idvideo=1012")!])
        showYTDViewController(self)
    }
    
    @IBAction func asdf() {
        print("uns")
    }

}