//
//  UserDefaults+Extension.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 01.01.2022.
//  Copyright © 2022 Dmitry Onishchuk. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    func reset() {
        let defaults = self
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}
