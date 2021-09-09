//
//  TestInternetManager.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

import Foundation
import UIKit

class TestInternetManager{
    
    static let shared = TestInternetManager()
    
    private init() {
        setup()
    }
    
    func setup(){
    }
    
    func getArray(completion: @escaping TestClosure) {
        completion((["TestValue1", "TestValue2"], nil))
    }
    
}

