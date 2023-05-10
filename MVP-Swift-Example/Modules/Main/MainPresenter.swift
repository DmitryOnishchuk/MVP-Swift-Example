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
    private var model: MainModelProtocol
    
    // MARK: Private Properties
    @Inject private var userDefaultsManager: UserDefaultsManager
    
    // MARK: - Override
    override var v: BaseViewProtocol? { view }
    override var m: BaseModelProtocol? { model }
    
    init(view: MainViewProtocol, model: MainModelProtocol) {
        self.view = view
        self.model = model
        super.init(view: view, model: model)
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
		let user = User(token: "test_token")
		let secondVC = SecondModuleBuilder().create(user: user) { [weak self] (user) in
			guard let `self` = self else { return }
			print("NEW User token: " + (user.token))
		}
		print("OLD User token: " + (user.token))
		v?.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}
