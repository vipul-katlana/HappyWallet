//
//  ContactUsForm.swift
//  Pet Poster
//
//  Created by Vipul  on 23/06/21.
//

import UIKit

class ContactFormViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Contact Us"
    }
    
    class func instance() -> ContactFormViewController? {
        return UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "ContactFormViewController") as? ContactFormViewController
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSendAction(_ sender: Any) {
        if txtName.text == "" {
            self.showTopMessage(message: "Please enter name", type: .Error)
        }else if txtEmail.text == "" {
            self.showTopMessage(message: "Please enter email", type: .Error)
        }else if txtPhone.text == "" {
            self.showTopMessage(message: "Please enter phone", type: .Error)
        }else if txtMessage.text == "" {
            self.showTopMessage(message: "Please enter message", type: .Error)
        }else {
            if !NetworkReachability().isNetworkAvailable() {
                GlobalUtility.showHud()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    GlobalUtility.hideHud()
                    self.showTopMessage(message: "Thankyou! for your query", type: .Success)
                    self.navigationController?.popViewController(animated: true)
                }
            }else {
                self.showTopMessage(message: "Please check internet connection", type: .Error)
            }
            
        }
    }
    
}

