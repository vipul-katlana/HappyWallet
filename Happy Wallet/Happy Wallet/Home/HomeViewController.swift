//
//  HomeViewController.swift
//  Happy Wallet
//
//  Created by Vipul  on 17/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var vwNav: UIView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblBalancee: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var homeData = [MonthlyRecord]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.vwNav.setShadow()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        if UserDefaultsManager.shared.getMonth() != dateFormatter.string(from: now) {
            UserDefaultsManager.shared.setAmount(amount: "0")
            UserDefaultsManager.shared.setMonth(month: dateFormatter.string(from: now))
            UserDefaultsManager.resetMonthData()
            UserDefaultsManager.resetDreamData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tm = UserDefaultsManager.getMonthlyData() {
            self.homeData = tm
        }
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        self.lblMonth.text = dateFormatter.string(from: now)
        UserDefaultsManager.shared.setMonth(month: dateFormatter.string(from: now))
        self.lblBalancee.text = "Wallet Balance $\(UserDefaultsManager.shared.getAmount())"
        self.tblView.reloadData()
    }
    
    @IBAction func btnAddExpenseAction(_ sender: Any) {
        if let VC = AddExpenseViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnAddBalance(_ sender: Any) {
        if let VC = AddBalanceViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.lblAmount.text = "- $\(homeData[indexPath.row].amount ?? "")"
        cell.lblDate.text = (homeData[indexPath.row].category ?? "")
        cell.lblDescription.text = (homeData[indexPath.row].description ?? "")
        cell.vwBg.setShadow()
        cell.vwBg.layer.borderWidth = 1
        cell.vwBg.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
    
    
}
