//
//  ContactUsViewController.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 16/05/21.
//

import UIKit
import MessageUI

class ContactUsViewController: BaseViewController {
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var vwRight: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwRight.roundCorners([.topLeft], radius: 50)
        self.lblText.text = "Hi, there!\nA \(AppConstants.appName) customer support team that's always just a click away."
    }
    
    
    class func instance() -> ContactUsViewController? {
        return UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContactAction(_ sender: Any) {
        if let VC = ContactFormViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func configureMailComposer(message: String) -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setSubject("\(AppConstants.appName)")
        mailComposeVC.setMessageBody("\(message)", isHTML: false)
        mailComposeVC.setToRecipients(["11myapp1994@gmail.com"])
        return mailComposeVC
    }
    
}

extension ContactUsViewController : MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
