//
//  LoginViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class LoginViewController: UIViewController {
  
  let viewModel = ViewModel()
  private let userModel = UserModel()
  
  @IBOutlet weak var usernameTxtField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!{
    didSet {
      passwordTextField.isSecureTextEntry = true
    }
  }
  
  @IBOutlet weak var validImage: UIImageView!{
    didSet {
      validImage.isHidden = true
    }
  }
  
  @IBOutlet weak var eyeButton: UIButton!
  
  @IBOutlet weak var loginBtn: UIButton!{
    didSet {
      loginBtn.isEnabled = false
      loginBtn.backgroundColor = UIColor(named: "invalidButton")
    }
  }
  
  @IBOutlet weak var loginBackground: UIView!{
    didSet {
      loginBackground.backgroundColor = UIColor(named: "invalidButton")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.loadDataUser()
    passwordTextField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    usernameTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
  }
  
  // MARK: Back Button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: forgot Button when Clicked -> Go To NewPassword View
  @IBAction func forgotPasswordClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "NewPasswordViewController", bundle: nil).instantiateViewController(withIdentifier: "NewPasswordViewController") as! NewPasswordViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: loginButton when Clicked -> Go To HomePage View
  @IBAction func loginButtonClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "HomepageViewController", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: Check Validation For Text Field
  @objc func checkValidation() {
    var isValidUsernameTxt = false
    var isValidPasswordStat = false
    let username = usernameTxtField.text
    let password = passwordTextField.text
    
    for uname in 0..<viewModel.userData.count{
      if username == viewModel.userData[uname].username {
        isValidUsernameTxt = true
        break
      } else {
        isValidUsernameTxt = false
      }
    }
    
    for uname in 0..<viewModel.userData.count{
      if password == viewModel.userData[uname].password {
        isValidPasswordStat = true
        break
      } else {
        isValidPasswordStat = false
      }
    }
    
    let isValidPasswordTxt = passwordTextField.validPassword(passwordTextField.text ?? "")
    
    if isValidUsernameTxt {
      validImage.isHidden = false
    }
    
    if isValidPasswordTxt && (isValidUsernameTxt && isValidPasswordStat) {
      loginBtn.isEnabled = true
      loginBtn.backgroundColor = UIColor(named: "PurpleButton")
      loginBackground.backgroundColor = UIColor(named: "PurpleButton")
    }
  }
  @IBAction func eyeButtonClicked(_ sender: UIButton) {
    if passwordTextField.isSecureTextEntry {
      eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      passwordTextField.isSecureTextEntry = false
    } else if !passwordTextField.isSecureTextEntry{
      eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
      passwordTextField.isSecureTextEntry = true
    }
  }
}
