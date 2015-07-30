//
//  ViewController.swift
//  Sound Shaker
//
//  Created by Yohannes Wijaya on 7/29/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.randomSongIndex = Int(arc4random_uniform(UInt32(self.songFilesPath.count)))
        self.initiateSoundPlayer()
        self.initiateTapGestureToPlayOrPauseSong()
        self.initiateSwipeRelatedGesturesToControlSongPlayback()
        self.initiateTapAndHoldGestureToStopSong()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Stored properties
    
    var songPlayer: AVAudioPlayer!
    let songFilesPath: [String]! = NSBundle.mainBundle().pathsForResourcesOfType(".mp3", inDirectory: "Audio Assets")
    let albumArtFilesPath: [String]! = NSBundle.mainBundle().pathsForResourcesOfType(".jpg", inDirectory: "Audio Assets")
    var randomSongIndex = 0
    var isPlaying = "nope"
    
    // MARK: - IBOutlet properties
    
    @IBOutlet weak var albumArtImageView: UIImageView! {
        didSet {
            self.albumArtImageView.userInteractionEnabled = true
        }
    }
    @IBOutlet weak var instructionsTextView: UITextView! {
        didSet {
            self.instructionsTextView.editable = false
        }
    }
    // MARK: - Local methods
    
    func initiateSoundPlayer() {
        do {
            songPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: self.songFilesPath[self.randomSongIndex]))
            songPlayer.prepareToPlay()
        }
        catch {
            print("something has gone awfully wrong...")
        }
    }
    
    
    func initiateSwipeRelatedGesturesToControlSongPlayback() {
        /*
        let directions: [UISwipeGestureRecognizerDirection] = [.Down, .Left, .Right]
        let recognizers: [UISwipeGestureRecognizer] = directions.map { direction in
        let gesture = UISwipeGestureRecognizer(target: self, action: "validateSwipeGesture")
        gesture.direction = direction
        self.someView.addGestureRecognizer(gesture)
        }
        */
        let swipeDirections: [UISwipeGestureRecognizerDirection] = [.Left, .Right]
        for swipeDirection in swipeDirections {
            let gesture = UISwipeGestureRecognizer(target: self, action: "validateGestureType:")
            gesture.direction = swipeDirection
            self.view.subviews[0].addGestureRecognizer(gesture)
        }
    }
    
    func initiateTapGestureToPlayOrPauseSong() {
        let tapGesture = UITapGestureRecognizer(target: self, action: "validateGestureType:")
        self.view.subviews[0].addGestureRecognizer(tapGesture)
    }
    
    func initiateTapAndHoldGestureToStopSong() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "validateGestureType:")
        longPressGesture.minimumPressDuration = 1.0
        self.view.subviews[0].addGestureRecognizer(longPressGesture)
    }
    
    func playOrPauseSong() {
        self.albumArtImageView.image = UIImage(contentsOfFile: self.albumArtFilesPath[self.randomSongIndex])
        if self.isPlaying == "nope" {
            self.songPlayer.play()
            self.isPlaying = "yup"
        }
        else {
            self.songPlayer.pause()
            self.isPlaying = "nope"
        }
    }
    
    func stopSong() {
        self.albumArtImageView.image = UIImage(named: "defaultAlbumCover")
        self.songPlayer.stop()
        self.songPlayer.currentTime = 0
    }
    
    func validateGestureType(gestureType: UIGestureRecognizer) {
        if let isGestureSwipe = gestureType as? UISwipeGestureRecognizer {
            switch isGestureSwipe.direction {
            case UISwipeGestureRecognizerDirection.Left:
                print("")
            case UISwipeGestureRecognizerDirection.Right:
                print("right")
            default:
                break
            }
        }
        else if let _ = gestureType as? UILongPressGestureRecognizer {
            self.stopSong()
            
        }
        else if let _ = gestureType as? UITapGestureRecognizer {
            self.playOrPauseSong()
        }
    }
    
    // MARK: - UIResponder methods override
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake {
        }
    }
    
}

