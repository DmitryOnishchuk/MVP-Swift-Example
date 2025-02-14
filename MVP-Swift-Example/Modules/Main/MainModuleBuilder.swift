//
//  MainModuleBuilder.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//

import UIKit

struct MainModuleBuilder {
    
    func create() -> UINavigationController {
        let mainNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNC") as! UINavigationController
        let mainVC = mainNC.topViewController as! MainVC
        let model = MainModel()
        let presenter = MainPresenter(view: mainVC, model: model)
        mainVC.presenter = presenter
        return mainNC
    }
    
}
