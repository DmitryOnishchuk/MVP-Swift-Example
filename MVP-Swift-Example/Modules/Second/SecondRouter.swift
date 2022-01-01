//
//  SecondRouter.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

import UIKit

protocol SecondRouterProtocol: BaseRouterProtocol {
    func exit()
}

final class SecondRouter: NSObject, RouterProtocol, SecondRouterProtocol {
    
    unowned var vc: UIViewController
    
    init(vc: UIViewController) {
        self.vc = vc
        super.init()
    }
    
    deinit {
        print("deinit SecondRouter")
    }
    
    func exit() {
        vc.navigationController?.popViewController(animated: true)
    }

    private func push(viewController: UIViewController) {
        vc.navigationController?.pushViewController(viewController, animated: true)
    }

}
