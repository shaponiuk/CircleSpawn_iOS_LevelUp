//
//  SpawnableCircle.swift
//  CircleSpawnApp
//
//  Created by daftcode on 20/03/2018.
//  Copyright © 2018 daftcode. All rights reserved.
//

import UIKit

class SpawnableCircle: UIView {

    // MARK: Properties
    
    // Coordinates, where the circle was touched
    var locationInCircle = CGPoint(x: 0, y: 0)
    
    // MARK: Init
    
    // Set the given frame, circle shape and the bright color
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = frame.size.height / 2
        self.backgroundColor = UIColor.randomBrightColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return random(min: 0.0, max: 1.0)
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(max > min)
        return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
    }
}

// Added random bright color generator
extension UIColor {
    static func randomBrightColor() -> UIColor {
        return UIColor(hue: .random(),
                       saturation: .random(min: 0.5, max: 1.0),
                       brightness: .random(min: 0.7, max: 1.0),
                       alpha: 1.0)
    }
}
