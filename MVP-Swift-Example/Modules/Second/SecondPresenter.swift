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
    private var model: SecondModelProtocol
    
	private var user: User
    
    // MARK: Private Properties
    @Inject private var userDefaultsManager: UserDefaultsManager
    
	private var callback: ((User) -> Void)?
	
    // MARK: - Override
    override var v: BaseViewProtocol? { view }
    override var m: BaseModelProtocol? { model }
    
	init(view: SecondViewProtocol, model: SecondModelProtocol, user: User, callback: ((User) -> Void)?) {
        self.view = view
        self.model = model
        self.user = user
		self.callback = callback
        super.init(view: view, model: model)
    }
    
    func setInfo() {
        view.setInfoLabel(text: "Test Info Label")
    }
    
    func back(){
		
		user.token = user.token + "_test"
		callback.map({ $0(user) })
		v?.navigationController?.popViewController(animated: true)
    }
    
}
