//
//  UserDefaultsManager.swift
//  BaseViewController
//
//  Created by Dmitry Onishchuk on 01.01.2022.
//

import Foundation
import UIKit

final class UserDefaultsManager {
    
    @UserDefaultCodable("User", defaultValue: User()) var user: User!
    @UserDefault("matchListRefreshed", defaultValue: nil) var matchListRefreshed: Date?
    @UserDefault("isLoggedIn", defaultValue: false) var isLoggedIn: Bool!
    
}


extension UserDefaultsManager {
    
    func clearAllData() {

        user = User()
        matchListRefreshed = nil
        isLoggedIn = false

        UserDefaults.standard.reset()
        UserDefaults.standard.synchronize()
        
    }
    
}
