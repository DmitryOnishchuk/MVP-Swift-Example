//
//  MainModel.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

protocol MainModelProtocol: AnyObject {
    func getDataFromInternetOrDB(comlete: @escaping TestClosure)
}

class MainModel: MainModelProtocol {

    deinit {
        print("deinit MainModel")
    }
    
    func getDataFromInternetOrDB(comlete: @escaping TestClosure) {
        TestInternetManager.shared.getArray(){[weak self] (array, errorMessage) in
            comlete((array, errorMessage))
        }
    }
    
}
