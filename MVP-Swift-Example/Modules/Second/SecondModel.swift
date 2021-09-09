//
//  SecondModel.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

protocol SecondModelProtocol: AnyObject {
    func test(comlete: @escaping TestClosure)
}

class SecondModel: SecondModelProtocol {

    deinit {
        print("deinit SecondModel")
    }
    
    func test(comlete: @escaping TestClosure) {
        TestInternetManager.shared.getArray(){[weak self] (array, errorMessage) in
            comlete((array, errorMessage))
        }
    }
    
}
