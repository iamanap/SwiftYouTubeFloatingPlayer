//
//  ViewController.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 5/19/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit


class ViewController: UIViewController, YTDProtocol {

    let videos = [Video.init(name: "Big Bunny", artist: "Google", url: NSURL(string: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")!),
                 Video.init(name: "Robo Toy", artist: "Google", url: NSURL(string: "http://techslides.com/demos/sample-videos/small.mp4")!),
                 Video.init(name: "Big Bunny", artist: "Google", url: NSURL(string: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")!),
                 Video.init(name: "Robo Toy", artist: "Google", url: NSURL(string: "http://techslides.com/demos/sample-videos/small.mp4")!),
                 Video.init(name: "Big Bunny", artist: "Google", url: NSURL(string: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")!),
                 Video.init(name: "Robo Toy", artist: "Google", url: NSURL(string: "http://techslides.com/demos/sample-videos/small.mp4")!),
                 Video.init(name: "Big Bunny", artist: "Google", url: NSURL(string: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")!),
                 Video.init(name: "Robo Toy", artist: "Google", url: NSURL(string: "http://techslides.com/demos/sample-videos/small.mp4")!)]
    
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
        let urls = [videos[0].url, videos[1].url]
        initYTD(urls, tableCellNibName: "VideoCell", delegate: self, dataSource: self)
        showYTDViewController(self)
    }
    
    @IBAction func asdf() {
        print("uns")
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell", forIndexPath: indexPath) as! VideoCell
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 74
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! VideoCell
        cell.labelArtist.text = videos[indexPath.row].artist
        cell.labelTitle.text = videos[indexPath.row].name
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        changeURL(videos[indexPath.row].url)
    }
}