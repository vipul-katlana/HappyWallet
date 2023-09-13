//
//  BaseViewController.swift
//  Condolence Message
//
//  Created by Vipul  on 03/06/21.
//

import UIKit
import SJSwiftSideMenuController

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLeftMenu() {
        SJSwiftSideMenuController.showLeftMenu()
    }
}
