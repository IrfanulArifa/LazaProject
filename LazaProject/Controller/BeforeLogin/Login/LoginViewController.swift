//
//  LoginViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class LoginViewController: UIViewController {
  
  let viewModel = ViewModel()
  
  @IBOutlet weak var welcomeTitle: UILabel!{
    didSet { welcomeTitle.font = UIFont(name: "Poppins-SemiBold", size: 28)}
  }
  
  @IBOutlet weak var subTitle: UILabel!{
    didSet { subTitle.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  @IBOutlet weak var usernameTitle: UILabel!{
    didSet { usernameTitle.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var usernameTxtField: UITextField!{
    didSet { usernameTxtField.font = UIFont(name: "Poppins-Regular", size: 14)
    }
  }
  @IBOutlet weak var passwordTitle: UILabel!{
    didSet { passwordTitle.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var passwordTextField: UITextField!{
    didSet {
      passwordTextField.isSecureTextEntry = true
      passwordTextField.font = UIFont(name: "Poppins-Regular", size: 14)
    }
  }
  
  @IBOutlet weak var validImage: UIImageView!{
    didSet { validImage.isHidden = true }
  }
  
  @IBOutlet weak var eyeButton: UIButton!
  
  @IBOutlet weak var forgotBtn: UIButton!{
    didSet { forgotBtn.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  @IBOutlet weak var rememberTxt: UILabel!{
    didSet { rememberTxt.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var byConnecting: UILabel!{
    didSet { byConnecting.font = UIFont(name: "Poppins-Regular", size: 12)}
  }
                                        
  @IBOutlet weak var withOur: UILabel!{
    didSet { withOur.font = UIFont(name: "Poppins-Regular", size: 12)}
  }
  
  @IBOutlet weak var termAndCondition: UIButton! {
    didSet { termAndCondition.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 12)}
  }
  
  
  @IBOutlet weak var loginBtn: UIButton!{
    didSet {
      loginBtn.isEnabled = false
      loginBtn.backgroundColor = UIColor(named: "invalidButton")
      loginBtn.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
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
    var passIndex = 0
    
    for uname in 0..<viewModel.userData.count{
      if username == viewModel.userData[uname].username {
        isValidUsernameTxt = true
        passIndex = uname
        break
      } else {
        isValidUsernameTxt = false
      }
    }
    
    if password == viewModel.userData[passIndex].password {
      isValidPasswordStat = true
    } else {
      isValidPasswordStat = false
    }
    
    let isValidPasswordTxt = passwordTextField.validPassword(passwordTextField.text ?? "")
    
    if isValidUsernameTxt {
      validImage.isHidden = false
    } else {
      validImage.isHidden = true
    }
    
    if isValidPasswordTxt && (isValidUsernameTxt && isValidPasswordStat) {
      loginBtn.isEnabled = true
      loginBtn.backgroundColor = UIColor(named: "PurpleButton")
      loginBackground.backgroundColor = UIColor(named: "PurpleButton")
    } else {
      loginBtn.isEnabled = false
      loginBtn.backgroundColor = UIColor(named: "invalidButton")
      loginBackground.backgroundColor = UIColor(named: "invalidButton")
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
