//
//  SecondPresenter.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

import Foundation
import UIKit

protocol SecondPresenterProtocol {
    func setInfo()
    func back()
}

final class SecondPresenter: SecondPresenterProtocol {
    
    unowned let view: SecondViewProtocol
    let router: SecondRouterProtocol
    let model: SecondModelProtocol
    
    init(view: SecondViewProtocol, router: SecondRouterProtocol, model: SecondModelProtocol) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    deinit {
        print("deinit SecondPresenter")
    }
    
    func setInfo() {
        view.setInfoLabel(text: "Test Info Label")
    }
    
    func back(){
        router.exit()
    }
    
}
