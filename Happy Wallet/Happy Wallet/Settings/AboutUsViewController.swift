//
//  AboutUsViewController.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 16/05/21.
//

import UIKit

class AboutUsViewController: BaseViewController {
    
    @IBOutlet weak var vwRight: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwRight.roundCorners([.topLeft], radius: 50)
    }
    
    
    class func instance() -> AboutUsViewController? {
        return UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController
    }
    
    
    @IBAction func btnMenuAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
