//
//  SecondPresenter.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

import Foundation
import UIKit

protocol SecondPresenterProtocol: BasePresenterProtocol {
    func setInfo()
    func back()
}

final class SecondPresenter: BasePresenter<SecondVC>, SecondPresenterProtocol {

    // MARK: - Variables
    private var view: SecondViewProtocol
    private var router: SecondRouterProtocol
    private var model: SecondModelProtocol
    
    let user: User
    
    // MARK: - Override
    override var v: BaseViewProtocol? { view }
    override var r: BaseRouterProtocol? { router }
    override var m: BaseModelProtocol? { model }
    
    init(view: SecondViewProtocol, router: SecondRouterProtocol, model: SecondModelProtocol, user: User) {
        self.view = view
        self.router = router
        self.model = model
        self.user = user
        super.init(view: view, router: router, model: model)
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
