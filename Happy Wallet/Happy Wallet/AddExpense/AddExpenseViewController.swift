//
//  AddExpenseViewController.swift
//  Happy Wallet
//
//  Created by Vipul  on 17/08/21.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func instance() -> AddExpenseViewController? {
        return UIStoryboard(name: "AddExpense", bundle: nil).instantiateViewController(withIdentifier: "AddExpenseViewController") as? AddExpenseViewController
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        if txtCategory.text == "" {
            self.showTopMessage(message: "Please enter category", type: .Error)
        }else if txtAmount.text == "" {
            self.showTopMessage(message: "Please enter amount", type: .Error)
        }else if Int(txtAmount.text ?? "0") ?? 0 <= 0 {
            self.showTopMessage(message: "Please enter amount must be greater than zero", type: .Error)
        }else if Int(txtAmount.text ?? "0") ?? 0 > Int(UserDefaultsManager.shared.getAmount())! {
            self.showTopMessage(message: "You dont have enough balance in wallet", type: .Error)
        }
        else if txtDescription.text == "" {
            self.showTopMessage(message: "Please enter description", type: .Error)
        }else {
            let tm = MonthlyRecord(category: self.txtCategory.text ?? "", amount: self.txtAmount.text ?? "", description: self.txtDescription.text ?? "")
            let newAmount = (Int(UserDefaultsManager.shared.getAmount() ) ?? 0) - (Int(self.txtAmount.text ?? "") ?? 0)
            UserDefaultsManager.shared.setAmount(amount: "\(newAmount)")
            var lastRecord = UserDefaultsManager.getMonthlyData()
            if lastRecord == nil {
                lastRecord = [tm]
            }else {
                lastRecord?.append(tm)
            }
            if let nw = lastRecord {
                UserDefaultsManager.setMonthlyData(loginModel: nw)
            }
            self.showTopMessage(message: "Expense added successfully", type: .Success)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
