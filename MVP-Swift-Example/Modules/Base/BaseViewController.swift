import UIKit
import Toast_Swift

class BaseViewController: UIViewController {

	var isKeyboardObserving: Bool { false }
	var isNavigationBarVisible: Bool { false }
	var navigationBarColor: UIColor? { .appGreen  }
	override var preferredStatusBarStyle: UIStatusBarStyle { navigationBarColor != nil ? .lightContent : .default}
	
	var basePresenter: BasePresenterProtocol? { nil }
	
	var textFieldSequence: [UITextField] { [] }
	lazy var textFieldToolbar: UIToolbar = {
		let toolbar = UIToolbar()
		toolbar.barStyle = .default
		toolbar.items = [
			UIBarButtonItem(image: UIImage(named: "arrow_up"), style: .plain, target: self, action: #selector(toolbarPrevButtonPressed)),
			UIBarButtonItem(image: UIImage(named: "arrow_down"), style: .plain, target: self, action: #selector(toolbarNextButtonPressed)),
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
			UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(toolbarDoneButtonPressed))
		]
		toolbar.items?.forEach { $0.tintColor = .appGreen }
		toolbar.sizeToFit()
		return toolbar
	}()
	
	@Inject private var userdefaultsManager: UserDefaultsManager
    lazy var loader = Loader(in: self.view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
		configureUI()
		basePresenter?.viewDidLoad()
		textFieldSequence.forEach { $0.inputAccessoryView = textFieldToolbar }
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		basePresenter?.viewWillAppear(animated)
		if isKeyboardObserving {
			beginKeyboardObserving()
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		basePresenter?.viewDidAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		basePresenter?.viewWillDisappear(animated)
		if isKeyboardObserving {
			endKeyboardObserving()
		}
	}
	
	func configureUI() {

	}
	
	// MARK: - Wait indicator
	
    func showLoadingIndicator() {
        self.loader.show(view: self.view)
    }
    
    func hideLoadingIndicator() {
        self.loader.hide()
    }
	
	// MARK: - Keyboard Toolbar
	@objc private func toolbarNextButtonPressed(_ sender: Any) {
		guard let index = textFieldSequence.firstIndex(where: { $0.isEditing }), textFieldSequence.count - 1 > index else { return }
		textFieldSequence[index + 1].becomeFirstResponder()
	}
	
	@objc private func toolbarPrevButtonPressed(_ sender: Any) {
		guard let index = textFieldSequence.firstIndex(where: { $0.isEditing }), index > 0 else { return }
		textFieldSequence[index - 1].becomeFirstResponder()
	}
	
	@objc private func toolbarDoneButtonPressed(_ sender: Any) {
		view.endEditing(true)
	}
	
}

extension BaseViewController {
	
    func showErrorToast(_ message: String) {
        showToast(title: "Error", msg: message)
    }
    
    public func showToast(title: String? = nil, msg: String, position: ToastPosition = .bottom) {
        view.hideAllToasts()
        if position == .top {
            let top: CGFloat = self.view.bounds.size.height / 4
            let center = CGPoint(x: self.view.bounds.size.width / 2.0, y: top)
            view.makeToast(msg, duration: 1.5, point: center, title: title, image: nil, completion: nil)
        } else if position == .bottom {
            let bottom: CGFloat = (self.view.bounds.size.height / 4) * 3
            let center = CGPoint(x: self.view.bounds.size.width / 2.0, y: bottom)
            view.makeToast(msg, duration: 1.5, point: center, title: title, image: nil, completion: nil)
        }
    }
    
	func showMessage(_ message: String, title: String? = nil, handler: (() -> Void)? = nil) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in handler?() }))
		present(alert, animated: true)
	}
	
	func showError(_ message: String, handler: (() -> Void)? = nil) {
		showMessage(message, title: "Помилка", handler: handler)
	}
	
}

extension BaseViewController: UIGestureRecognizerDelegate { }
