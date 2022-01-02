//
//  MainModel.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

protocol MainModelProtocol: BaseModelProtocol {
    func getDataFromInternetOrDB(comlete: @escaping TestClosure)
}

class MainModel: MainModelProtocol {

    @Inject private var testInternetManager: TestInternetManager
    
    deinit {
        print("deinit MainModel")
    }
    
    func getDataFromInternetOrDB(comlete: @escaping TestClosure) {
        testInternetManager.getArray(){[weak self] (array, errorMessage) in
            comlete((array, errorMessage))
        }
    }
    
}
