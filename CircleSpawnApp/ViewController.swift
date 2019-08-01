//
//  ViewController.swift
//  CircleSpawnApp
//
//  Created by daftcode on 20/03/2018.
//  Copyright © 2018 daftcode. All rights reserved.
//  Modified by Szymon Haponiuk
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doubleTapGestureSetup()
    }
  
    // MARK: Methods
    
    // Sets up the doubleTapGestureRecognizer and attaches it to the screen
    func doubleTapGestureSetup() {
        let doubleTapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(doubleTapHandler(_:)))
        doubleTapGestureRecogniser.numberOfTapsRequired = Constants.doubleTapTouches
        doubleTapGestureRecogniser.delegate = self
        
        self.view.addGestureRecognizer(doubleTapGestureRecogniser)
    }
    
    
    // MARK: Gesture Methods
    
    // Creates a new circle and places it in the tapped place on the self.view
    // Creates longPress and tripleTap gesture recognizers and attaches them to the new circle
    @objc func doubleTapHandler(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        let circleFrameOrigin = CGPoint(x: location.x - Constants.circleStandardRadius,
                                        y: location.y - Constants.circleStandardRadius)
        let circleFrameSize = CGSize(width: Constants.circleStandardDiameter,
                                     height: Constants.circleStandardDiameter)
        
        let newCircle = SpawnableCircle(frame: CGRect(origin: circleFrameOrigin, size: circleFrameSize))
        
        let longPressGestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(_:)))
        longPressGestureRecogniser.allowableMovement = .infinity
        longPressGestureRecogniser.minimumPressDuration = 0.3
        
        let tripleTapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(tripleTapHandler(_:)))
        tripleTapGestureRecogniser.numberOfTapsRequired = Constants.tripleTapTouches
        tripleTapGestureRecogniser.delegate = self
      
        newCircle.alpha = 0
      
        newCircle.addGestureRecognizer(longPressGestureRecogniser)
        newCircle.addGestureRecognizer(tripleTapGestureRecogniser)
        
        self.view.addSubview(newCircle)
      
        UIView.animate(withDuration: 0.5) {
            newCircle.alpha = Constants.circleStandardAlpha
        }
    }
    
    // Coordinates lifting and draging of the longPressed circle
    @objc func longPressHandler(_ sender: UILongPressGestureRecognizer) {
        
        // Function properties
        
        let location = sender.location(in: self.view)
        let pressedCircle = sender.view! as! SpawnableCircle
        
        // Subfunctions
        
        // Prepare the circle for the changed state
        func beganHandler() {
            let locationInCircle = sender.location(in: pressedCircle)
            pressedCircle.locationInCircle = locationInCircle
            pressedCircle.locationInCircle.x += Constants.circleExtendedStandardRadiusDifference
            pressedCircle.locationInCircle.y += Constants.circleExtendedStandardRadiusDifference
          
            let transform = CGAffineTransform(scaleX: Constants.circleRadiusRatio, y: Constants.circleRadiusRatio)
          
            UIView.animate(withDuration: 0.5) {
                pressedCircle.transform = transform
   
            }
            
            self.view.bringSubview(toFront: pressedCircle)
        }
        
        // Change the circle location
        func changedHandler() {
          let circleOrigin = CGPoint(x: location.x - pressedCircle.locationInCircle.x,
                                     y: location.y - pressedCircle.locationInCircle.y)
            pressedCircle.frame.origin = circleOrigin
        }
        
        // Return circle to the standard state
        func endedHandler() {
            let transform = CGAffineTransform(scaleX: 1, y: 1)
          
            UIView.animate(withDuration: 0.5) {
                pressedCircle.transform = transform
            }
        }
        
        // Main logic
        
        // Prepare the circle/set extended parameters
        if sender.state == .began {
            beganHandler()
        }
        // Change the location of the circle
        else if sender.state == .changed {
            changedHandler()
        }
        // Return circle to the standard parameters
        else {
            endedHandler()
        }
    }
    
    // Deletes the tapped circle
    @objc func tripleTapHandler(_ sender: UITapGestureRecognizer) {
        let tappedCircle = sender.view!
        let transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
      
        UIView.animate(withDuration: 0.7, animations: {
            tappedCircle.transform = transform
        }) { _ in
            tappedCircle.removeFromSuperview()
            tappedCircle.removeGestureRecognizer(sender)
        }
    }
    
    
    // MARK: UIGestureRecognizerDelegate
    
    // Fail doubleTapGestureRecogniser when there's a tripleTapGestureRecogniser
    // If triple tapped on the self.view, doubleTap will recognise, because tripleTap
    // is attached to a circle
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let doubleTap = otherGestureRecognizer as? UITapGestureRecognizer {
            if let tripleTap = gestureRecognizer as? UITapGestureRecognizer {
                return doubleTap.numberOfTapsRequired == Constants.doubleTapTouches
                    && tripleTap.numberOfTapsRequired == Constants.tripleTapTouches
            }
        }
        return false
    }
    
}




