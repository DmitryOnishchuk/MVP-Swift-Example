//
//  SecondModel.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

protocol SecondModelProtocol: BaseModelProtocol {
    func test(comlete: @escaping TestClosure)
}

class SecondModel: SecondModelProtocol {

    @Inject private var testInternetManager: TestInternetManager
    
    deinit {
        print("deinit SecondModel")
    }
    
    func test(comlete: @escaping TestClosure) {
        testInternetManager.getArray(){[weak self] (array, errorMessage) in
            comlete((array, errorMessage))
        }
    }
    
}
