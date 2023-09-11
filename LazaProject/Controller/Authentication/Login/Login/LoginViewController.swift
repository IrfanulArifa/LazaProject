//
//  LoginViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit
import SnackBar

class LoginViewController: UIViewController {
  
  // MARK: Load Login View Model
  let loginModel = LoginViewModel()
  
  
  // MARK: Initial Setting -> UIHidden, isSecureTextEntry, Font Type
  @IBOutlet weak var disableView: UIView!{
    didSet { disableView.isHidden = true }
  }
  
  @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!{
    didSet { indicatorLoading.isHidden = true }
  }
  
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
    didSet { loginBtn.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15) }
  }
  
  @IBOutlet weak var loginBackground: UIView!
  
  @IBOutlet weak var rememberMeSwitch: UISwitch!{
    didSet {
      rememberMeSwitch.isOn = false
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // MARK: Reactive TextField
    navigationController?.setNavigationBarHidden(true, animated: true)
    passwordTextField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    usernameTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    checkUserView()
  }
  
  private func goToVerify() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "VerifyAccountViewController") as! VerifyAccountViewController
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  private func checkUserView() {
    let rememberUser = UserDefaults.standard.string(forKey: "rememberme")
    if rememberUser != "" {
      usernameTxtField.text = rememberUser
    }
  }
  
  private func goToForget() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  private func goToHome() {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    self.view.window?.windowScene?.keyWindow?.rootViewController = vc
  }
  
  private func goToSignUp() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  private func goToSetProfile() {
    guard let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetProfileViewController") as? SetProfileViewController else { return }
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  func startingAnimation() {
    self.indicatorLoading.startAnimating()
    self.indicatorLoading.isHidden = false
    self.disableView.isHidden = false
  }
  
  func hidingAnimation() {
    self.indicatorLoading.stopAnimating()
    self.indicatorLoading.isHidden = true
    self.disableView.isHidden = true
  }
  
  // MARK: forgot Button when Clicked -> Go To NewPassword View
  @IBAction func forgotPasswordClicked(_ sender: Any) {
    goToForget()
  }
  
  // MARK: loginButton when Clicked -> Go To HomePage View
  @IBAction func loginButtonClicked(_ sender: UIButton) {
    if rememberMeSwitch.isOn {
      UserDefaults.standard.set(usernameTxtField.text!, forKey: "rememberme")
    }
    startingAnimation()
    loginModel.login(username: usernameTxtField.text!, password: passwordTextField.text!) { [weak self] response in
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.hidingAnimation()
        self.showAlert(title: "Login", message: "Redirecting...") {
          DispatchQueue.main.async {
            guard let loginAccess = response?.access_token else { print("Login Access Invalid"); return }
            guard let refreshAccess = response?.refresh_token else { print("Refresh Token Invalid"); return }
            self.loginModel.jumpClick = {
              DispatchQueue.main.async { [unowned self] in
                self.goToHome()
              }
            }
            self.loginModel.jumpToSetProfile = {
              DispatchQueue.main.async { [unowned self] in
                self.goToSetProfile()
              }
            }
            self.loginModel.invalidToken = { [unowned self] in
              DispatchQueue.main.async {
                self.showAlert(title: "Login Failed", message: "Invalid Token")
              }
            }
            self.loginModel.getProfileData(token: loginAccess, refreshToken: refreshAccess)
          }
        }
      }
    } onError: { error in
      DispatchQueue.main.async { [unowned self] in
        self.hidingAnimation()
        if error == "Key: 'Login.Username' Error:Field validation for 'Username' failed on the 'required' tag\nKey: 'Login.Password' Error:Field validation for 'Password' failed on the 'required' tag" {
          invalidSnackBar.make(in: self.view, message: "Username and Password is Empty!", duration: .lengthLong).show()
        } else if error == "Key: 'Login.Password' Error:Field validation for 'Password' failed on the 'required' tag" {
          invalidSnackBar.make(in: self.view, message: "Password is Empty", duration: .lengthLong).show()
        } else if error == "username or password is invalid" {
          invalidSnackBar.make(in: self.view, message: "Username or Password is Invalid", duration: .lengthLong).show()
        } else if error == "Key: 'Login.Username' Error:Field validation for 'Username' failed on the 'required' tag" {
          invalidSnackBar.make(in: self.view, message: "Username is Empty", duration: .lengthLong).show()
        } else if error == "Key: 'Login.Password' Error:Field validation for 'Password' failed on the 'min' tag" {
          invalidSnackBar.make(in: self.view, message: "Invalid Password", duration: .lengthLong).show()
        } else {
          self.showAlert(title: "Account not Verified!", message: error.capitalized){
            self.goToVerify()
          }
        }
      }
    }
  }
  
  // MARK: Check Validation For Text Field
  @objc private func checkValidation() {
    let username = usernameTxtField.text ?? ""
    let isValidUsernameTxt = username.count > 6
    
    if isValidUsernameTxt {
      validImage.isHidden = false
    } else {
      validImage.isHidden = true
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
  
  @IBAction func signUpButtonClicked(_ sender: UIButton) {
    goToSignUp()
  }
}
