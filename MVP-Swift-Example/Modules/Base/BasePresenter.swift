import UIKit

protocol BasePresenterProtocol {
	func viewDidLoad()
	func viewWillAppear(_ animated: Bool)
	func viewDidAppear(_ animated: Bool)
	func viewWillDisappear(_ animated: Bool)
}

class BasePresenter<T: BaseViewController>: NSObject {
	
	private(set) weak var v: BaseViewProtocol?
    private(set) weak var r: BaseRouterProtocol?
    private(set) weak var m: BaseModelProtocol?
	var navigationController: UINavigationController? { return v?.navigationController }
	
    
	init(view: BaseViewProtocol?, router: BaseRouterProtocol?, model: BaseModelProtocol?) {
		super.init()
		self.v = view
        self.r = router
        self.m = model
	}

	func configureController() {
		
	}
    
    func controllerWillAppear(_ animated: Bool) {
        
    }
	
	func controllerDidAppear(_ animated: Bool) {
		
	}
    
    func controllerWillDisappear(_ animated: Bool) {
        
    }
	
}

extension BasePresenter: BasePresenterProtocol {
	
	func viewDidLoad() {
		configureController()
	}
	
	func viewWillAppear(_ animated: Bool) {
		controllerWillAppear(animated)
	}
	
	func viewDidAppear(_ animated: Bool) {
		controllerDidAppear(animated)
	}
	
	func viewWillDisappear(_ animated: Bool) {
		controllerWillDisappear(animated)
	}
	
}
