//
//  SignUpViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class SignUpViewController: UIViewController {
  
  let viewModel = ViewModel()
  
  @IBOutlet weak var usernameTxtField: UITextField!
  @IBOutlet weak var passwordTxtField: UITextField!{
    didSet {
      passwordTxtField.isSecureTextEntry = true
    }
  }
  @IBOutlet weak var emailAddressTxtField: UITextField!
  @IBOutlet weak var firstnameTxtField: UITextField!
  @IBOutlet weak var lastnameTxtField: UITextField!
  @IBOutlet weak var phonenumberTxtField: UITextField!
  @IBOutlet weak var validUsername: UIImageView!{
    didSet {
      validUsername.isHidden = true
    }
  }
  
  @IBOutlet weak var validPassword: UILabel!{
    didSet {
      validPassword.isHidden = true
    }
  }
  
  @IBOutlet weak var validEmail: UIImageView!{
    didSet {
      validEmail.isHidden = true
    }
  }
  
  @IBOutlet weak var validFirstName: UIImageView!{
    didSet {
      validFirstName.isHidden = true
    }
  }
  
  @IBOutlet weak var validLastName: UIImageView!{
    didSet {
      validLastName.isHidden = true
    }
  }
  
  @IBOutlet weak var validNumber: UIImageView!{
    didSet {
      validNumber.isHidden = true
    }
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    passwordTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    emailAddressTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    phonenumberTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    usernameTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    firstnameTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    lastnameTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
  }
  
  // MARK: Back Button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: SignUp Button when Clicked -> Go to Wellcome View
  @IBAction func signUpButtonClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @objc func checkValidation(){
    let validPasswordTxt = passwordTxtField.validPassword(passwordTxtField.text ?? "")
    let validEmailTxt = emailAddressTxtField.validEmail(emailAddressTxtField.text ?? "")
    let validNumberTxt = phonenumberTxtField.validNumber(phonenumberTxtField.text ?? "")
    let validFirstNameTxt = firstnameTxtField.text !=  ""
    let validLastNameTxt = lastnameTxtField.text != ""
    let userNameTxt = usernameTxtField.text != ""
    
    if validEmailTxt {
      validEmail.isHidden = false
    }
    if validPasswordTxt {
      validPassword.isHidden = false
      
    }
    if validNumberTxt {
      validNumber.isHidden = false
    }
    
    if validFirstNameTxt {
      validFirstName.isHidden = false
    }
    
    if validLastNameTxt {
      validLastName.isHidden = false
    }
    
    if userNameTxt {
      validUsername.isHidden = false
    }
    
    if ( validEmailTxt && validNumberTxt && validPasswordTxt && validNumberTxt && validFirstNameTxt && validLastNameTxt ) {
      viewModel.saveProfil(name: usernameTxtField.text!, email: emailAddressTxtField.text!, firstname: firstnameTxtField.text!, lastname: lastnameTxtField.text!, phonenumber: phonenumberTxtField.text!, password: passwordTxtField.text!)
    }
  }
}
