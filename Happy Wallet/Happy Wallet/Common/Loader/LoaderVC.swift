//
//  LoaderVC.swift
//  LISTENIN
//
//  Created by hb on 28/04/17.
//
//

import UIKit
import Lottie
/// Loader View controller to be added when webservice call is made
class LoaderVC:  UIViewController {
    
    /// Lottie animation view
    var animationView : AnimationView!
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.userInterfaceStyle == .dark {
            self.viewDidLoad()
        }else {
            self.viewDidLoad()
        }
    }
    
    /// Method is called when view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        //  addAnimation()
        //  self.doInitialSettings()
        
        animationView = AnimationView(name: "loading")
        
        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.center = self.view.center
        animationView.loopMode = .loop
        animationView.isHidden = false
        view.addSubview(animationView)
        animationView.play { (played) in
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    /// viewWillappear
    ///
    /// - Parameter animated: animated
    /// Method is called when view will appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView.play { (played) in
            
        }
    }
    /// Method is called when view disappears
    ///
    /// - Parameter animated: animated
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // animationView.pause()
        animationView.pause()
    }
    
    
    
    
}
