//
//  MainPresenter.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//

import Foundation
import UIKit

protocol MainPresenterProtocol {
    func setInfo()
    func setTestArrayFromInternetOrDB()
    func openSecondVC()
}

final class MainPresenter: MainPresenterProtocol {
    
    unowned let view: MainViewProtocol
    let router: MainRouterProtocol
    let model: MainModelProtocol
    
    init(view: MainViewProtocol, router: MainRouterProtocol, model: MainModelProtocol) {
        self.view = view
        self.router = router
        self.model = model
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
                self.view.setInfoLabel(text: er)
            }else{
                for item in array {
                    print(item)
                }
            }
        }
    }
    
    func openSecondVC(){
        router.openSecondVC()
    }
    
}
