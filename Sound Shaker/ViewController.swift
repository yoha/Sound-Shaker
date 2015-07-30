//
//  ViewController.swift
//  Sound Shaker
//
//  Created by Yohannes Wijaya on 7/29/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumArtImageView.userInteractionEnabled = true
        let swipeDirections: [UISwipeGestureRecognizerDirection] = [.Down, .Left, .Right]
        for swipeDirection in swipeDirections {
            let gesture = UISwipeGestureRecognizer(target: self, action: "validateSwipeGesture:")
            gesture.direction = swipeDirection
            self.view.subviews[0].addGestureRecognizer(gesture)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBOutlet properties
    
    @IBOutlet weak var albumArtImageView: UIImageView!
        /*{
        didSet {
            /*
            let directions: [UISwipeGestureRecognizerDirection] = [.Down, .Left, .Right]
            let recognizers: [UISwipeGestureRecognizer] = directions.map { direction in
            let gesture = UISwipeGestureRecognizer(target: self, action: "validateSwipeGesture")
            gesture.direction = direction
            self.someView.addGestureRecognizer(gesture)
            }
            */
        }
    }
    */
    
    // MARK: - Local methods
    
    func validateSwipeGesture(swipeGesture: UISwipeGestureRecognizer) {
        switch swipeGesture.direction {
        case UISwipeGestureRecognizerDirection.Down:
            print("down")
        case UISwipeGestureRecognizerDirection.Left:
            print("left")
        case UISwipeGestureRecognizerDirection.Right:
            print("right")
        default:
            break
        }
    }
    
//    func validateSwipeGesture(swipeGesture: UISwipeGestureRecognizer) {
//        if let isSwipeGesture = swipeGesture as? UISwipeGestureRecognizer {
//            switch isSwipeGesture.direction {
//            case UISwipeGestureRecognizerDirection.Down:
//                print("down")
//            case UISwipeGestureRecognizerDirection.Left:
//                print("left")
//            case UISwipeGestureRecognizerDirection.Right:
//                print("right")
//            default:
//                break
//            }
//        }
//    }
    
}

