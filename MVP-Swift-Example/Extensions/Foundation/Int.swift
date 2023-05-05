//
//  Int.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 28.07.2022.
//  Copyright © 2022 Dmitry Onishchuk. All rights reserved.
//

import UIKit

extension Int {
    
    var asString: String { String(self) }
    
    var asCgFloat: CGFloat { CGFloat(self) }
    
    var asDouble: Double { Double(self) }
    
    func asString(withUnits units: String) -> String { return "\(self) \(units)" }
    
    func degreesToRads() -> Double {
        return (Double(self) * .pi / 180)
    }

}
