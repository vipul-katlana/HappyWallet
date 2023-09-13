//
//  TabBarViewController.swift
//  Book Finder
//
//  Created by Vipul  on 15/08/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func instance() -> TabBarViewController? {
        return UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
    }

}
