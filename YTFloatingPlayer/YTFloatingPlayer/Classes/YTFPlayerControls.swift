//
//  YTDPlayerControls.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 5/31/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit
import AVFoundation.AVPlayer

extension YTFViewController {
    
    @IBAction func playTouched(sender: AnyObject) {
        if (isPlaying) {
            playerView.pause()
        } else {
            playerView.play()
        }
    }
    
    @IBAction func fullScreenTouched(sender: AnyObject) {
        if (!isFullscreen) {
            setPlayerToFullscreen()
        } else {
            setPlayerToNormalScreen()
        }
    }
    
    @IBAction func touchDragInsideSlider(sender: AnyObject) {
        dragginSlider = true
    }
    
    
    @IBAction func valueChangedSlider(sender: AnyObject) {
        playerView.currentTime = Double(slider.value)
        playerView.play()
    }
    
    @IBAction func touchUpInsideSlider(sender: AnyObject) {
        dragginSlider = false
    }
    
    func playIndex(index: Int) {
        print("Index \(index)")
        playerView.url = urls![index]
        playerView.play()
        progressIndicatorView.hidden = false
        progressIndicatorView.startAnimating()
    }
}

extension YTFViewController: PlayerViewDelegate {
    
    func playerVideo(player: PlayerView, statusPlayer: PVStatus, error: NSError?) {
        
        switch statusPlayer {
        case AVPlayerStatus.Unknown:
            print("Unknown")
            break
        case AVPlayerStatus.Failed:
            print("Failed")
            break
        default:
            readyToPlay()
        }
    }
    
    func readyToPlay() {
        progressIndicatorView.stopAnimating()
        progressIndicatorView.hidden = true
        playerTapGesture = UITapGestureRecognizer(target: self, action: #selector(YTFViewController.showPlayerControls))
        playerView.addGestureRecognizer(playerTapGesture!)
        print("Ready to Play")
        self.playerView.play()
    }
    
    func playerVideo(player: PlayerView, statusItemPlayer: PVItemStatus, error: NSError?) {
    }
    
    func playerVideo(player: PlayerView, loadedTimeRanges: [PVTimeRange]) {
        if (progressIndicatorView.hidden == false) {
            progressIndicatorView.stopAnimating()
            progressIndicatorView.hidden = true
        }
        
        if let first = loadedTimeRanges.first {
            let bufferedSeconds = Float(CMTimeGetSeconds(first.start) + CMTimeGetSeconds(first.duration))
            progress.progress = bufferedSeconds / slider.maximumValue
        }
    }
    
    func playerVideo(player: PlayerView, duration: Double) {
        let duration = Int(duration)
        self.entireTime.text = timeFormatted(duration)
        slider.maximumValue = Float(duration)
    }
    
    func playerVideo(player: PlayerView, currentTime: Double) {
        let curTime = Int(currentTime)
        self.currentTime.text = timeFormatted(curTime)
        if (!dragginSlider && (Int(slider.value) != curTime)) { // Change every second
            slider.value = Float(currentTime)
        }
    }
    
    func playerVideo(player: PlayerView, rate: Float) {
        print(rate)
        if (rate == 1.0) {
            isPlaying = true
            play.setImage(UIImage(named: "pause"), forState: UIControlState.Normal)
            hideTimer?.invalidate()
            showPlayerControls()
        } else {
            isPlaying = false
            play.setImage(UIImage(named: "play"), forState: UIControlState.Normal)
        }
    }
    
    func playerVideo(playerFinished player: PlayerView) {
        currentUrlIndex += 1
        playIndex(currentUrlIndex)
    }
    
    func timeFormatted(totalSeconds: Int) -> String {
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}