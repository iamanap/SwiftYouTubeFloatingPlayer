//
//  Song.swift
//  YouTubeFloatingPlayer
//
//  Created by Ana Paula on 6/8/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit

class Video {
    var name: String
    var artist: String
    var url: NSURL
    
    init(name: String, artist: String, url: NSURL) {
        self.name = name
        self.artist = artist
        self.url = url
    }
}