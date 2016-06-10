//
//  YTDAnimation.swift
//  YTDraggablePlayer
//
//  Created by Ana Paula on 6/6/16.
//  Copyright © 2016 Ana Paula. All rights reserved.
//

import UIKit

enum UIPanGestureRecognizerDirection {
    case Undefined
    case Up
    case Down
    case Left
    case Right
}

extension YTFViewController {
    
    //MARK: Player Controls Animations
    
    func showPlayerControls() {
        if (!isMinimized) {
            UIView.animateWithDuration(0.6, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.backPlayerControlsView.alpha = 0.55
                self.playerControlsView.alpha = 1.0
                self.minimizeButton.alpha = 1.0
                
                }, completion: nil)
            hideTimer?.invalidate()
            hideTimer = nil
            hideTimer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: #selector(YTFViewController.hidePlayerControls(_:)), userInfo: 1.0, repeats: false)
        }
    }
    
    func hidePlayerControls(dontAnimate: Bool) {
        if (dontAnimate) {
            self.backPlayerControlsView.alpha = 0.0
            self.playerControlsView.alpha = 0.0
        } else {
            if (isPlaying) {
                UIView.animateWithDuration(0.6, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.backPlayerControlsView.alpha = 0.0
                    self.playerControlsView.alpha = 0.0
                    self.minimizeButton.alpha = 0.0
                    
                    }, completion: nil)
            }
        }
    }
    
    //MARK: Video Animations
    
    func setPlayerToFullscreen() {
        self.hidePlayerControls(true)
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.minimizeButton.hidden = true
            self.playerView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            
            self.playerView.frame = CGRectMake(self.initialFirstViewFrame!.origin.x, self.initialFirstViewFrame!.origin.x, self.initialFirstViewFrame!.size.width, self.initialFirstViewFrame!.size.height)
            
            }, completion: { finished in
                self.isFullscreen = true
                self.fullscreen.setImage(UIImage(named: "unfullscreen"), forState: UIControlState.Normal)
                
                let originY = self.initialFirstViewFrame!.size.width - self.playerControlsFrame!.height
                
                self.backPlayerControlsView.frame.origin.x = self.initialFirstViewFrame!.origin.x
                self.backPlayerControlsView.frame.origin.y = originY
                self.backPlayerControlsView.frame.size.width = self.initialFirstViewFrame!.size.height
                
                self.playerControlsView.frame.origin.x = self.initialFirstViewFrame!.origin.x
                self.playerControlsView.frame.origin.y = originY
                self.playerControlsView.frame.size.width = self.initialFirstViewFrame!.size.height
                
                self.showPlayerControls()
        })
    }
    
    func setPlayerToNormalScreen() {
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.playerView.transform = CGAffineTransformMakeRotation(0)
            
            self.playerView.frame = CGRectMake(self.playerViewFrame!.origin.x, self.playerViewFrame!.origin.x, self.playerViewFrame!.size.width, self.playerViewFrame!.size.height)
            
            let originY = self.playerViewFrame!.size.height - self.playerControlsFrame!.height
            self.backPlayerControlsView.frame.origin.x = self.initialFirstViewFrame!.origin.x
            self.backPlayerControlsView.frame.origin.y = originY
            self.backPlayerControlsView.frame.size.width = self.playerViewFrame!.size.width
            
            self.playerControlsView.frame.origin.x = self.initialFirstViewFrame!.origin.x
            self.playerControlsView.frame.origin.y = originY
            self.playerControlsView.frame.size.width = self.playerViewFrame!.size.width
            
            }, completion: { finished in
                self.isFullscreen = false
                self.minimizeButton.hidden = false
                self.fullscreen.setImage(UIImage(named: "fullscreen"), forState: UIControlState.Normal)
        })
    }
    
    func panAction(recognizer: UIPanGestureRecognizer) {
        if (!isFullscreen) {
            let yPlayerLocation = recognizer.locationInView(self.view?.window).y
            
            switch recognizer.state {
            case .Began:
                onRecognizerStateBegan(yPlayerLocation, recognizer: recognizer)
                break
            case .Changed:
                onRecognizerStateChanged(yPlayerLocation, recognizer: recognizer)
                break
            default:
                onRecognizerStateEnded(yPlayerLocation, recognizer: recognizer)
            }
        }
    }
    
    func onRecognizerStateBegan(yPlayerLocation: CGFloat, recognizer: UIPanGestureRecognizer) {
        tableViewContainer.backgroundColor = UIColor.whiteColor()
        hidePlayerControls(true)
        panGestureDirection = UIPanGestureRecognizerDirection.Undefined
        
        let velocity = recognizer.velocityInView(recognizer.view)
        detectPanDirection(velocity)
        
        touchPositionStartY = recognizer.locationInView(self.playerView).y
        touchPositionStartX = recognizer.locationInView(self.playerView).x
        
    }
    
    func onRecognizerStateChanged(yPlayerLocation: CGFloat, recognizer: UIPanGestureRecognizer) {
        if (panGestureDirection == UIPanGestureRecognizerDirection.Down ||
            panGestureDirection == UIPanGestureRecognizerDirection.Up) {
            let trueOffset = yPlayerLocation - touchPositionStartY!
            let xOffset = trueOffset * 0.35
            adjustViewOnVerticalPan(yPlayerLocation, trueOffset: trueOffset, xOffset: xOffset, recognizer: recognizer)
            
        } else {
            adjustViewOnHorizontalPan(recognizer)
        }
    }
    
    func onRecognizerStateEnded(yPlayerLocation: CGFloat, recognizer: UIPanGestureRecognizer) {
        if (panGestureDirection == UIPanGestureRecognizerDirection.Down ||
            panGestureDirection == UIPanGestureRecognizerDirection.Up) {
            if (self.view.frame.origin.y < 0) {
                expandViews()
                recognizer.setTranslation(CGPointZero, inView: recognizer.view)
                return
                
            } else {
                if (self.view.frame.origin.y > (initialFirstViewFrame!.size.height / 2)) {
                    minimizeViews()
                    recognizer.setTranslation(CGPointZero, inView: recognizer.view)
                    return
                } else {
                    expandViews()
                    recognizer.setTranslation(CGPointZero, inView: recognizer.view)
                }
            }
            
        } else if (panGestureDirection == UIPanGestureRecognizerDirection.Left) {
            if (tableViewContainer.alpha <= 0) {
                if (self.view?.frame.origin.x < 0) {
                    removeViews()
                    
                } else {
                    animateViewToRightOrLeft(recognizer)
                    
                }
            }
            
        } else {
            if (tableViewContainer.alpha <= 0) {
                if (self.view?.frame.origin.x > initialFirstViewFrame!.size.width - 50) {
                    removeViews()
                    
                } else {
                    animateViewToRightOrLeft(recognizer)
                    
                }
                
            }
            
        }
    }
    
    func detectPanDirection(velocity: CGPoint) {
        minimizeButton.hidden = true
        let isVerticalGesture = fabs(velocity.y) > fabs(velocity.x)
        
        if (isVerticalGesture) {
            
            if (velocity.y > 0) {
                panGestureDirection = UIPanGestureRecognizerDirection.Down
            } else {
                panGestureDirection = UIPanGestureRecognizerDirection.Up
            }
            
        } else {
            
            if (velocity.x > 0) {
                panGestureDirection = UIPanGestureRecognizerDirection.Right
            } else {
                panGestureDirection = UIPanGestureRecognizerDirection.Left
            }
        }
    }
    
    func adjustViewOnVerticalPan(yPlayerLocation: CGFloat, trueOffset: CGFloat, xOffset: CGFloat, recognizer: UIPanGestureRecognizer) {
        
        if (Float(trueOffset) >= (restrictTrueOffset! + 60) ||
            Float(xOffset) >= (restrictOffset! + 60)) {
            
            let trueOffset = initialFirstViewFrame!.size.height - 100
            let xOffset = initialFirstViewFrame!.size.width - 160
            
            //Use this offset to adjust the position of your view accordingly
            viewMinimizedFrame?.origin.y = trueOffset
            viewMinimizedFrame?.origin.x = xOffset - 6
            viewMinimizedFrame?.size.width = initialFirstViewFrame!.size.width
            
            playerViewMinimizedFrame!.size.width = self.view.bounds.size.width - xOffset
            playerViewMinimizedFrame!.size.height = 200 - xOffset * 0.5
            
            UIView.animateWithDuration(0.05, delay: 0.0, options: .CurveEaseInOut, animations: {
                self.playerView.frame = self.playerViewMinimizedFrame!
                self.view.frame = self.viewMinimizedFrame!
                self.tableViewContainer.alpha = 0.0
                }, completion: { finished in
                    self.isMinimized = true
            })
            recognizer.setTranslation(CGPointZero, inView: recognizer.view)
            
        } else {
            //Use this offset to adjust the position of your view accordingly
            viewMinimizedFrame?.origin.y = trueOffset
            viewMinimizedFrame?.origin.x = xOffset - 6
            viewMinimizedFrame?.size.width = initialFirstViewFrame!.size.width
            
            playerViewMinimizedFrame!.size.width = self.view.bounds.size.width - xOffset
            playerViewMinimizedFrame!.size.height = 200 - xOffset * 0.5
            
            let restrictY = initialFirstViewFrame!.size.height - playerView!.frame.size.height - 10
            
            if (self.tableView.frame.origin.y < restrictY && self.tableView.frame.origin.y > 0) {
                UIView.animateWithDuration(0.09, delay: 0.0, options: .CurveEaseInOut, animations: {
                    self.playerView.frame = self.playerViewMinimizedFrame!
                    self.view.frame = self.viewMinimizedFrame!
                    
                    let percentage = (yPlayerLocation + 200) / self.initialFirstViewFrame!.size.height
                    self.tableViewContainer.alpha = 1.0 - percentage
                    self.transparentView!.alpha = 1.0 - percentage
                    
                    }, completion: { finished in
                        if (self.panGestureDirection == UIPanGestureRecognizerDirection.Down) {
                            self.onView?.bringSubviewToFront(self.view)
                        }
                })
                
            } else if (viewMinimizedFrame!.origin.y < restrictY && viewMinimizedFrame!.origin.y > 0) {
                UIView.animateWithDuration(0.09, delay: 0.0, options: .CurveEaseInOut, animations: {
                    self.playerView.frame = self.playerViewMinimizedFrame!
                    self.view.frame = self.viewMinimizedFrame!
                    
                    }, completion: nil)
            }
            
            recognizer.setTranslation(CGPointZero, inView: recognizer.view)
        }
    }
    
    func adjustViewOnHorizontalPan(recognizer: UIPanGestureRecognizer) {
        let x = self.view.frame.origin.x
        
        if (panGestureDirection == UIPanGestureRecognizerDirection.Left ||
            panGestureDirection == UIPanGestureRecognizerDirection.Right) {
            if (self.tableViewContainer.alpha <= 0) {
                let velocity = recognizer.velocityInView(recognizer.view)
                
                let isVerticalGesture = fabs(velocity.y) > fabs(velocity.x)
                
                let translation = recognizer.translationInView(self.view)
                self.view?.center = CGPointMake(self.view!.center.x + translation.x, self.view!.center.y)
                
                if (!isVerticalGesture) {
                    recognizer.view?.alpha = detectHorizontalPanRecognizerViewAlpha(x, velocity: velocity, recognizer: recognizer)
                }
                recognizer.setTranslation(CGPointZero, inView: recognizer.view)
            }
            
        }
    }
    
    func detectHorizontalPanRecognizerViewAlpha(x: CGFloat, velocity: CGPoint, recognizer: UIPanGestureRecognizer) -> CGFloat {
        let percentage = x / self.initialFirstViewFrame!.size.width
        
        if (panGestureDirection == UIPanGestureRecognizerDirection.Left) {
            return percentage
            
        } else {
            if (velocity.x > 0) {
                return 1.0 - percentage
            } else {
                return percentage
            }
        }
    }
    
    func animateViewToRightOrLeft(recognizer: UIPanGestureRecognizer) {
        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.view.frame = self.viewMinimizedFrame!
            self.playerView!.frame = self.playerViewFrame!
            self.playerView.frame = CGRectMake(self.playerView!.frame.origin.x, self.playerView!.frame.origin.x, self.playerViewMinimizedFrame!.size.width, self.playerViewMinimizedFrame!.size.height)
            self.tableViewContainer!.alpha = 0.0
            self.playerView.alpha = 1.0
            
            }, completion: nil)
        
        recognizer.setTranslation(CGPointZero, inView: recognizer.view)
        
    }
    
    func minimizeViews() {
        tableViewContainer.backgroundColor = UIColor.whiteColor()
        minimizeButton.hidden = true
        hidePlayerControls(true)
        let trueOffset = initialFirstViewFrame!.size.height - 100
        let xOffset = initialFirstViewFrame!.size.width - 160
        
        viewMinimizedFrame!.origin.y = trueOffset
        viewMinimizedFrame!.origin.x = xOffset - 6
        viewMinimizedFrame!.size.width = initialFirstViewFrame!.size.width
        
        playerViewMinimizedFrame!.size.width = self.view.bounds.size.width - xOffset
        playerViewMinimizedFrame!.size.height = 200 - xOffset * 0.5
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
            self.playerView.frame = self.playerViewMinimizedFrame!
            self.view.frame = self.viewMinimizedFrame!
            self.tableViewContainer.alpha = 0.0
            self.transparentView?.alpha = 0.0
            }, completion: { finished in
                self.isMinimized = true
                if let playerGesture = self.playerTapGesture {
                    self.playerView.removeGestureRecognizer(playerGesture)
                }
                self.playerTapGesture = nil
                self.playerTapGesture = UITapGestureRecognizer(target: self, action: #selector(YTFViewController.expandViews))
                self.playerView.addGestureRecognizer(self.playerTapGesture!)
        })
    }
    
    func expandViews() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseIn, animations: {
            self.playerView.frame = self.playerViewFrame!
            self.view.frame = self.initialFirstViewFrame!
            self.playerView.alpha = 1.0
            self.tableViewContainer.alpha = 1.0
            self.transparentView?.alpha = 1.0
            }, completion: { finished in
                self.isMinimized = false
                self.minimizeButton.hidden = false
                self.playerView.removeGestureRecognizer(self.playerTapGesture!)
                self.playerTapGesture = nil
                self.playerTapGesture = UITapGestureRecognizer(target: self, action: #selector(YTFViewController.showPlayerControls))
                self.playerView.addGestureRecognizer(self.playerTapGesture!)
                self.tableViewContainer.backgroundColor = UIColor.blackColor()
                self.showPlayerControls()
        })
    }
    
    func removeViews() {
        self.view.removeFromSuperview()
        self.playerView.resetPlayer()
        self.playerView.removeFromSuperview()
        self.tableView.removeFromSuperview()
        self.tableViewContainer.removeFromSuperview()
        self.transparentView?.removeFromSuperview()
    }
    
}