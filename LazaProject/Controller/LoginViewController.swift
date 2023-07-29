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
  
  @IBOutlet weak var validText: UILabel!{
    didSet {
      validText.isHidden = true
    }
  }
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
  
  @objc func checkValidation() {
    var isValidUsernameTxt = false
    var isValidPasswordStat = false
    let username = usernameTxtField.text
    let password = passwordTextField.text
    var index = 0
    
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
        index = uname
        break
      } else {
        isValidPasswordStat = false
      }
    }
    
    let isValidPasswordTxt = passwordTextField.validPassword(passwordTextField.text ?? "")
    
    if isValidUsernameTxt == true {
      validImage.isHidden = false
    }
    
    if isValidPasswordTxt && (isValidUsernameTxt && isValidPasswordStat) {
      loginBtn.isEnabled = true
      loginBtn.backgroundColor = UIColor(named: "PurpleButton")
      loginBackground.backgroundColor = UIColor(named: "PurpleButton")
      validText.isHidden = false
//      let username = viewModel.userData[index].username
//      let email = viewModel.userData[index].email
//      let firstname = viewModel.userData[index].name.firstname
//      let lastname = viewModel.userData[index].name.lastname
//      let phonenumber = viewModel.userData[index].phone
//      
//      viewModel.saveProfil(name: username, email: email, firstname: firstname, lastname: lastname, phonenumber: phonenumber)
//      print("User Default Jalan")
    }
  }
}