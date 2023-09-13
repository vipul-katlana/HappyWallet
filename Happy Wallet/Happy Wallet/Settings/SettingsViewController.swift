//
//  SettingsViewController.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 15/05/21.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    @IBOutlet weak var vwFrst: UIView!
    @IBOutlet weak var vwSeconnd: UIView!
    @IBOutlet weak var vwThird: UIView!
    @IBOutlet weak var vwFourth: UIView!
    @IBOutlet weak var vwFifth: UIView!
    @IBOutlet weak var lblVersionn: UILabel!
    @IBOutlet weak var lblLogout: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.setBorder(vw: self.vwFrst)
        self.setBorder(vw: self.vwSeconnd)
        self.setBorder(vw: self.vwThird)
        self.setBorder(vw: self.vwFourth)
        self.setBorder(vw: self.vwFifth)
        
        
        
        self.lblVersionn.text = "Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"
    }
    
    class func instance() -> SettingsViewController? {
        return UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
    }
    
    @IBAction func btnFAQAction(_ sender: Any) {
        
    }
    
    func setBorder(vw: UIView) {
        vw.layer.borderWidth = 1
        vw.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        vw.layer.cornerRadius = 7
    }
    
    
    @IBAction func btnAboutUsAction(_ sender: Any) {
        if let VC = AboutUsViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
    @IBAction func btnSendFeedBackAction(_ sender: Any) {
        
    }
    
    @IBAction func btnContactUsAction(_ sender: Any) {
        if let VC = ContactUsViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnInstructionAction(_ sender: Any) {
        
        
    }
    
    @IBAction func btnRateAction(_ sender: Any) {
        if let url = URL(string: AppConstants.appStoreLink) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Earlier versions
                if UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
    }
    
    @IBAction func btnReferAction(_ sender: Any) {
        let atext = "Download \(AppConstants.appName) from app store \(AppConstants.appStoreLink)"
        let activityVC = UIActivityViewController(activityItems: [atext], applicationActivities: nil)
        activityVC.setValue("\(AppConstants.appName)", forKey: "subject")
        present(activityVC, animated: true, completion: nil)
    }
    
}
