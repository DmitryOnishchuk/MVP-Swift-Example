//
//  AppDelegate.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//

import UIKit
import Toast_Swift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
    private lazy var testInternetManager: TestInternetManager = TestInternetManager.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        DependencyManager {
            Module { self.userDefaultsManager }
            Module { self.testInternetManager }
        }.build()
        
        configureToastUI()
        
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
    
    private func configureToastUI() {
        var style = ToastManager.shared.style
        style.titleAlignment = .center
        style.messageAlignment = .center
        ToastManager.shared.style = style
    }
    
}

// выводим print только для разработчиков
func print(_ items: Any...) {
    #if DEBUG
    Swift.print(items.first)
    #endif
}
