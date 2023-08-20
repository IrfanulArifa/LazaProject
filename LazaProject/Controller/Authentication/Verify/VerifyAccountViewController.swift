//
//  VerifyAccountViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 19/08/23.
//

import UIKit

class VerifyAccountViewController: UIViewController {
  
  // MARK: Import View Model
  let verifyModel = VerifyAccountViewModel()
  var emailValue : String?
  
  // MARK: Label
  @IBOutlet weak var verifyLbl: UILabel!{
    didSet { verifyLbl.font = UIFont(name: "Poppins-SemiBold", size: 28) }
  }
  
  @IBOutlet weak var emailLbl: UILabel!{
    didSet { emailLbl.font = UIFont(name: "Poppins-Regular", size: 14) }
  }
  @IBOutlet weak var timestampLbl: UILabel!{
    didSet { timestampLbl.font = UIFont(name: "Poppins-SemiBold", size: 15) }
  }
  
  // MARK: TextField
  @IBOutlet weak var emailTxtField: UITextField!{
    didSet { emailTxtField.font = UIFont(name: "Poppins-Regular", size: 14)}
  }
  
  // MARK: Button
  @IBOutlet weak var resendBtn: UIButton!{
    didSet { resendBtn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15) }
  }
  
  @IBOutlet weak var backToLogin: UIButton!{
    didSet { backToLogin.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    verifyModel.resendVerify(email: emailTxtField.text! ) { response in
      DispatchQueue.main.async {
        self.showAlert(title: "Verify Resend", message: "Please Check your Email box")
      }
    } onError: { error in
      DispatchQueue.main.async {
        if error == "please enter a valid email address" {
          DispatchQueue.main.async {
            self.showAlert(title: "Invalid Email", message: error.capitalized)
          }
        } else {
          DispatchQueue.main.async {
            self.showAlert(title: "Already Registered", message: error.capitalized)
          }
        }
      }
    }
  }
  
  func goToLogin() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    goToLogin()
  }
  
  @IBAction func backToLogin(_ sender: UIButton) {
    goToLogin()
  }
}
