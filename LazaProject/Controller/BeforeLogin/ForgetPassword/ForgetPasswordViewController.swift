//
//  ForgetPasswordViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
  
  @IBOutlet weak var forgotTxt: UILabel!{
    didSet {
      forgotTxt.font = UIFont(name: "Poppins-SemiBold", size: 28)
    }
  }
  
  @IBOutlet weak var emailAddressTxt: UILabel!{
    didSet {
      emailAddressTxt.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var emailAdressTxtField: UITextField!{
    didSet {
      emailAdressTxtField.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var pleaseWriteEmail: UILabel!{
    didSet {
      pleaseWriteEmail.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var confirmButton: UIButton!{
    didSet {
      confirmButton.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var validImage: UIImageView!{
    didSet {
      validImage.isHidden = true
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    emailAdressTxtField.addTarget(self, action: #selector(emailValidation), for: .editingChanged)
  }
  
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func confirmMailClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "VerificationCodeViewController", bundle: nil).instantiateViewController(withIdentifier: "VerificationCodeViewController")
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @objc func emailValidation() {
    let validEmail = emailAdressTxtField.validEmail(emailAdressTxtField.text ?? "")
    if validEmail {
      validImage.isHidden = false
    }
  }
}
