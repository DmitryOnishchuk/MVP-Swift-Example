//
//  AppDelegate.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        DependencyManager {
            Module { self.userDefaultsManager }
        }.build()
        
        loadView()
        
        return true
    }

}

extension AppDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func loadView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainModuleBuilder().create()
        window?.makeKeyAndVisible()
    }
}

// выводим print только для разработчиков
func print(_ items: Any...) {
    #if DEBUG
    Swift.print(items[0])
    #endif
}
