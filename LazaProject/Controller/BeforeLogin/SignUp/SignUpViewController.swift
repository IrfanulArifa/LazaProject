//
//  SignUpViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class SignUpViewController: UIViewController {
  
  let viewModel = ViewModel()
  
  var validEmailTxt = false
  var validPasswordTxt = false
  var validConfirmTxt = false
  var userNameTxt = false
  
  @IBOutlet weak var usernameTxtField: UITextField!
  
  @IBOutlet weak var passwordTxtField: UITextField!{
    didSet {
      passwordTxtField.isSecureTextEntry = true
    }
  }
  
  @IBOutlet weak var confirmPasswordTxtField: UITextField!{
    didSet {
      confirmPasswordTxtField.isSecureTextEntry = true
    }
  }
  
  
  @IBOutlet weak var emailAddressTxtField: UITextField!
  
  @IBOutlet weak var validUsername: UIImageView!{
    didSet {
      validUsername.isHidden = true
    }
  }
  
  @IBOutlet weak var validEmail: UIImageView!{
    didSet {
      validEmail.isHidden = true
    }
  }
  
  @IBOutlet weak var passwordEyeButton: UIButton!
  @IBOutlet weak var confirmPasswordEyeButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    passwordTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    emailAddressTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    usernameTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    confirmPasswordTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    
  }
  
  // MARK: Back Button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: SignUp Button when Clicked -> Go to Wellcome View
  @IBAction func signUpButtonClicked(_ sender: Any) {
    if passwordTxtField.text == "" || emailAddressTxtField.text == "" || usernameTxtField.text == "" || confirmPasswordTxtField.text == "" {
      AlertManager.showEmptyData(on: self)
    } else if !validEmailTxt {
      AlertManager.invalidEmail(on: self)
    } else if !validPasswordTxt {
      AlertManager.showNotStrongPasswordAlert(on: self)
    } else if !validConfirmTxt {
      AlertManager.showNotStrongPasswordAlert(on: self)
    } else if !( passwordTxtField.text == confirmPasswordTxtField.text ) {
      AlertManager.showDifferentPasswordAlert(on: self)
    } else if ( validPasswordTxt && validConfirmTxt) && ( passwordTxtField.text == confirmPasswordTxtField.text ) {
      viewModel.saveProfil(name: usernameTxtField.text!, email: emailAddressTxtField.text!, password: passwordTxtField.text!)
      let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
      self.navigationController?.pushViewController(storyboard, animated: true)
    }
  }
  
  
  @IBAction func passwordEyeClicked(_ sender: UIButton) {
    if passwordTxtField.isSecureTextEntry {
      passwordEyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      passwordTxtField.isSecureTextEntry = false
    } else if !passwordTxtField.isSecureTextEntry{
      passwordEyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
      passwordTxtField.isSecureTextEntry = true
    }
  }
  
  @IBAction func confirmEyeClicked(_ sender: UIButton) {
    if confirmPasswordTxtField.isSecureTextEntry {
      confirmPasswordEyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      confirmPasswordTxtField.isSecureTextEntry = false
    } else if !confirmPasswordTxtField.isSecureTextEntry{
      confirmPasswordEyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
      confirmPasswordTxtField.isSecureTextEntry = true
    }
  }
  
  // MARK: Check Validation For Textfields
  @objc func checkValidation(){
    validPasswordTxt = passwordTxtField.validPassword(passwordTxtField.text ?? "")
    validEmailTxt = emailAddressTxtField.validEmail(emailAddressTxtField.text ?? "")
    validConfirmTxt = confirmPasswordTxtField.validPassword(confirmPasswordTxtField.text ?? "")
    userNameTxt = usernameTxtField.text != ""
    
    if validEmailTxt {
      validEmail.isHidden = false
    }
    if userNameTxt {
      validUsername.isHidden = false
    }
    
  }
}