//
//  UserDefaultsManager.swift
//  BaseViewController
//
//  Created by Dmitry Onishchuk on 01.01.2022.
//

import Foundation
import UIKit

enum UserDefaultKey: String {
	case user = "User"
	case matchListRefreshed = "matchListRefreshed"
	case isLoggedIn = "isLoggedIn"
}

final class UserDefaultsManager {
    
    @UserDefaultCodable(UserDefaultKey.user.rawValue, defaultValue: User()) var user: User!
    @UserDefault(UserDefaultKey.matchListRefreshed.rawValue, defaultValue: nil) var matchListRefreshed: Date?
    @UserDefault(UserDefaultKey.isLoggedIn.rawValue, defaultValue: false) var isLoggedIn: Bool!
    
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
