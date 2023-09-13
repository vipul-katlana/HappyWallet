//
//  NavColor.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 15/05/21.
//

import UIKit

final class NavController: UINavigationController {
    
    fileprivate var duringPushAnimation = false
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
        self.isNavigationBarHidden = false
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor =  .clear
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :  UIColor.white ,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20.0)]
        
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = true
            self.view.backgroundColor = UIColor.clear
    }
    
    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        super.pushViewController(viewController, animated: animated)
    }
    
    
    
}


extension NavController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        let backImage = UIImage(named: "btn_back")?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil,
                                   action: nil)
        item.image = backImage
        item.tintColor = .white
        item.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        viewController.navigationItem.backBarButtonItem = item
        self.navigationBar.backIndicatorImage = backImage
        self.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0);
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? NavController else { return }
        swipeNavigationController.duringPushAnimation = false
    }
    
}


extension NavController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true
        }
        return viewControllers.count > 1 && duringPushAnimation == false
        
        
    }
}




