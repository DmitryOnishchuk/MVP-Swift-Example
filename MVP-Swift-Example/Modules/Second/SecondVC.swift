//
//  SecondVC.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//  Copyright © 2021 Dmitry Onishchuk. All rights reserved.
//

import UIKit

protocol SecondViewProtocol: MainViewProtocol {
    func setInfoLabel(text: String)
}

final class SecondVC: BaseViewController, SecondViewProtocol{
    
    // MARK: - Outlets
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - Variables
    var presenter: SecondPresenterProtocol!
    
    // MARK: - Override
    override var basePresenter: BasePresenterProtocol? { presenter }
    
    override func configureUI() {
        presenter.setInfo()
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("deinit SecondVC")
    }
    

}

// MARK: - Actions
extension SecondVC {
    @IBAction func backButtonAction(_ sender: UIButton) {
        presenter.back()
    }
}

// MARK: - Methods
extension SecondVC {
    
    func setInfoLabel(text: String){
        infoLabel.text = text
    }
}
