//
//  MainPresenter.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//

import Foundation
import UIKit

protocol MainPresenterProtocol: BasePresenterProtocol {
    func setInfo()
    func setTestArrayFromInternetOrDB()
    func openSecondVC()
}

final class MainPresenter: BasePresenter<MainVC>, MainPresenterProtocol {
    
    // MARK: - Variables
    private var view: MainViewProtocol
    private var router: MainRouterProtocol
    private var model: MainModelProtocol
    
    // MARK: - Override
    override var v: BaseViewProtocol? { view }
    override var r: BaseRouterProtocol? { router }
    override var m: BaseModelProtocol? { model }
    
    init(view: MainViewProtocol, router: MainRouterProtocol, model: MainModelProtocol) {
        self.view = view
        self.router = router
        self.model = model
        super.init(view: view, router: router, model: model)
    }
    
    deinit {
        print("deinit MainPresenter")
    }
    
    func setInfo() {
        view.setInfoLabel(text: "Test Info Label")
    }
    
    func setTestArrayFromInternetOrDB(){
        model.getDataFromInternetOrDB { [weak self] (array, errorMessage) in
            guard let `self` = self else { return }
            if let er = errorMessage{
                self.view.showError(er)
            }else{
                for item in array {
                    self.view.setInfoLabel(text: item)
                }
            }
        }
    }
    
    func openSecondVC(){
        router.openSecondVC()
    }
    
}
