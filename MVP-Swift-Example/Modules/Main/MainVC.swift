//
//  ViewController.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setInfoLabel(text: String)
}

final class MainVC: UIViewController {
    
    var presenter: MainPresenterProtocol!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setInfo()
    }
    
    deinit {
        print("deinit MainVC")
    }
    
    @IBAction func getValueFromInternetOrDB(_ sender: UIButton) {
        presenter.setTestArrayFromInternetOrDB()
    }
    
    @IBAction func openSecondVC(_ sender: UIButton) {
        presenter.openSecondVC()
    }
}


extension MainVC: MainViewProtocol {
    
    func setInfoLabel(text: String){
        infoLabel.text = text
    }
}
