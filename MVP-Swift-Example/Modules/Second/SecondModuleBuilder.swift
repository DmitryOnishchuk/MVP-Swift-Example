//
//  SecondModuleBuilder.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

import UIKit

struct SecondModuleBuilder {
    
    func create(user: User) -> SecondVC {
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: String(describing: SecondVC.self)) as! SecondVC
        let model = SecondModel()
        let router = SecondRouter(vc: secondVC)
        let presenter = SecondPresenter(view: secondVC, router: router, model: model, user: user)
        secondVC.presenter = presenter
        return secondVC
    }
    
}
