//
//  DreamViewController.swift
//  Happy Wallet
//
//  Created by Vipul  on 17/08/21.
//

import UIKit

class AddDreamViewController: UIViewController {

    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var yxyAmountHave: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    var isFromEdit = false
    var lastData : DreamRecord?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromEdit {
            self.txtDescription.text = lastData?.description ?? ""
            self.txtAmount.text = lastData?.amount ?? ""
            self.txtCategory.text = lastData?.category ?? ""
        }
    }
    


    class func instance() -> AddDreamViewController? {
        return UIStoryboard(name: "AddExpense", bundle: nil).instantiateViewController(withIdentifier: "AddDreamViewController") as? AddDreamViewController
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        if txtCategory.text == "" {
            self.showTopMessage(message: "Please enter dream category", type: .Error)
        }else if txtAmount.text == "" {
            self.showTopMessage(message: "Please enter amount required to complete dream", type: .Error)
        }else if yxyAmountHave.text == "" {
            self.showTopMessage(message: "Please enter amount you have to complete dream", type: .Error)
        }else if txtDescription.text == "" {
            self.showTopMessage(message: "Please enter description", type: .Error)
        }else {
            let tm = DreamRecord(category: self.txtCategory.text ?? "", amount: self.txtAmount.text ?? "", amountAvailable: self.yxyAmountHave.text ?? "", description: self.txtDescription.text ?? "")
            var lastRecord = UserDefaultsManager.getDreamData()
            if isFromEdit {
                lastRecord?[index] = tm
                UserDefaultsManager.setDreamData(loginModel: lastRecord!)
            }else {
                if lastRecord == nil {
                    lastRecord = [tm]
                }else {
                    lastRecord?.append(tm)
                }
                if let nw = lastRecord {
                    UserDefaultsManager.setDreamData(loginModel: nw)
                }
            }
            self.showTopMessage(message: "Dream added successfully", type: .Success)
            self.navigationController?.popViewController(animated: true)
            
        }
    }

}
