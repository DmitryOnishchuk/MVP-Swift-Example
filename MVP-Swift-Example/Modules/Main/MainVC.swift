//
//  ViewController.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 09.09.2021.
//

import UIKit

protocol MainViewProtocol: BaseViewProtocol {
    func setInfoLabel(text: String)
}

final class MainVC: BaseViewController, MainViewProtocol {
    
    // MARK: - Outlets
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var bottomSpaceConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    var presenter: MainPresenterProtocol!
    
    // MARK: - Override
    override var isNavigationBarVisible: Bool { true }
    override var basePresenter: BasePresenterProtocol? { presenter }
    override var isKeyboardObserving: Bool { true }
    
    override func configureUI() {
        textField.delegate = self
        presenter.setInfo()
    }
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit {
        print("deinit MainVC")
    }
}

// MARK: - Actions
extension MainVC {
    @IBAction func getValueFromInternetOrDB(_ sender: UIButton) {
        presenter.setTestArrayFromInternetOrDB()
    }
    
    @IBAction func openSecondVC(_ sender: UIButton) {
        presenter.openSecondVC()
    }
    
    @IBAction func showToasAction(_ sender: UIButton) {
        showErrorToast("Message")
    }
    
    @IBAction func showLoaderAction(_ sender: UIButton) {
        showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.hideLoadingIndicator()
        }
    }
}

// MARK: - Methods
extension MainVC {
    func setInfoLabel(text: String){
        showToast(msg: text)
        infoLabel.text = text
    }
}


// MARK: UITextFieldDelegate
extension MainVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: Keyboard
extension MainVC {
    override func keyboardWillShow(withHeight keyboardHeight: CGFloat, duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            let bottom = keyboardHeight + 22
            self.bottomSpaceConstraint.constant = bottom
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
        })
    }
    
    override func keyboardWillChangeFrame(to keyboardHeight: CGFloat, withDuration duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            let bottom = keyboardHeight + 22
            self.bottomSpaceConstraint.constant = bottom
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
        })
    }
    
    override func keyboardWillHide(withDuration duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.bottomSpaceConstraint.constant = 22
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
        })
    }
}
