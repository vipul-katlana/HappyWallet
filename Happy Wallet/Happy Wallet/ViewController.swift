//
//  ViewController.swift
//  Happy Wallet
//
//  Created by Vipul  on 17/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabVC = TabBarViewController.instance() {
            AppConstants.appDelegate.window?.rootViewController = tabVC
        }
    }
    
}


