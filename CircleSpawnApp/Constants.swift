//
//  Constants.swift
//  CircleSpawnApp
//
//  Created by Szymon Haponiuk on 22/03/2018.
//  Copyright © 2018 daftcode. All rights reserved.
//

import UIKit

struct Constants {
    static let doubleTapTouches = 2
    static let tripleTapTouches = 3
    
    static let circleStandardDiameter: CGFloat = 100
    static let circleStandardRadius = circleStandardDiameter / 2
    static let circleExtendedDiameter = circleStandardDiameter * 1.2
    static let circleExtendedRadius = circleExtendedDiameter / 2
    
    static let circleExtendedStandardRadiusDifference = circleExtendedRadius - circleStandardRadius
  
    static let circleRadiusRatio = circleExtendedRadius / circleStandardRadius
    
    static let circleStandardAlpha: CGFloat = 1
    static let circleLiftedAlpha: CGFloat = 0.7
}
