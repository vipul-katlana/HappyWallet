//
//  AddBalanceViewController.swift
//  Happy Wallet
//
//  Created by Vipul  on 17/08/21.
//

import UIKit

class AddBalanceViewController: UIViewController {
    
    
    @IBOutlet weak var txtAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    class func instance() -> AddBalanceViewController? {
        return UIStoryboard(name: "AddExpense", bundle: nil).instantiateViewController(withIdentifier: "AddBalanceViewController") as? AddBalanceViewController
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        if txtAmount.text == "" {
            self.showTopMessage(message: "Please enter amount for this month", type: .Error)
        }else {
            UserDefaultsManager.shared.setAmount(amount: self.txtAmount.text ?? "")
            self.showTopMessage(message: "Wallet update successfully", type: .Success)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
