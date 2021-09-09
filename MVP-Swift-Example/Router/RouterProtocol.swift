//
//  RouterProtocol.swift
//  OnishchukTest
//
//  Created by Dmitry Onishchuk on 04.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    
    associatedtype VC: UIViewController
    var vc: VC { get }
    
}
