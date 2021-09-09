//
//  SecondVC.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

import UIKit

protocol SecondViewProtocol: AnyObject {
    func setInfoLabel(text: String)
}

final class SecondVC: UIViewController {
    
    var presenter: SecondPresenterProtocol!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setInfo()
    }
    
    deinit {
        print("deinit SecondVC")
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        presenter.back()
    }
}


extension SecondVC: SecondViewProtocol {
    
    func setInfoLabel(text: String){
        infoLabel.text = text
    }
}
