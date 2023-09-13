//
//  DreamViewController.swift
//  Happy Wallet
//
//  Created by Vipul  on 17/08/21.
//

import UIKit

class DreamViewController: UIViewController {
    
    var dreamData = [DreamRecord]()
    @IBOutlet weak var lblAmountRequired: UILabel!
    @IBOutlet weak var lblAmountAvailable: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tm = UserDefaultsManager.getDreamData() {
            self.dreamData = tm
            var amountRequired = 0
            var amountAvailable = 0
            for item in self.dreamData {
                amountRequired = amountRequired + (Int(item.amount ?? "0") ?? 0)
                amountAvailable = amountAvailable + (Int(item.amountAvailable ?? "0") ?? 0)
            }
            self.lblAmountRequired.text = "Amount Required: $\(amountRequired)"
            self.lblAmountAvailable.text = "Amount Available: $\(amountAvailable)"
        }
        self.tblView.reloadData()
    }
    
    
    @IBAction func btnAddDreamAction(_ sender: Any) {
        if let VC = AddDreamViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}


extension DreamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dreamData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DreamTableViewCell", for: indexPath) as! DreamTableViewCell
        cell.lblDate.text = dreamData[indexPath.row].category ?? ""
        cell.lblAmount.text = "Amount Required: $\(dreamData[indexPath.row].amount ?? "")"
        cell.lblAmountAcchive.text = "Amount Available: $\(dreamData[indexPath.row].amountAvailable ?? "")"
        cell.lblDescription.text = dreamData[indexPath.row].description ?? ""
        cell.vwBg.setShadow()
        cell.vwBg.layer.borderWidth = 1
        cell.vwBg.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let VC = AddDreamViewController.instance() {
            VC.isFromEdit = true
            VC.lastData = dreamData[indexPath.row]
            VC.index = indexPath.row
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
