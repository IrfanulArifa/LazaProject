//
//  LoginViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class LoginViewController: UIViewController {
  
  let viewModel = ViewModel()
  let loginModel = LoginViewModel()
  
  @IBOutlet weak var disableView: UIView!{
    didSet {
      disableView.isHidden = true
    }
  }
  
  @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!{
    didSet {
      indicatorLoading.isHidden = true
    }
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
    didSet {
      loginBtn.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var loginBackground: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.loadDataUser()
    passwordTextField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    usernameTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
  }
  
  // MARK: Back Button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: forgot Button when Clicked -> Go To NewPassword View
  @IBAction func forgotPasswordClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "ForgetPasswordViewController", bundle: nil).instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: loginButton when Clicked -> Go To HomePage View
  @IBAction func loginButtonClicked(_ sender: UIButton) {
    self.indicatorLoading.isHidden = false
    self.indicatorLoading.startAnimating()
    loginModel.login(username: usernameTxtField.text!, password: passwordTextField.text!) { response in
      DispatchQueue.main.async {
        self.disableView.isHidden = false
        self.indicatorLoading.stopAnimating()
        self.indicatorLoading.isHidden = true
        let alert = UIAlertController(title: "Login Success", message: "Redirecting...", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
          DispatchQueue.main.async {
            guard let loginAccess = response?.access_token else { print("Login Access")
              return }
            self?.loginModel.jumpClick = {
              DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "HomepageViewController", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                self?.navigationController?.pushViewController(vc, animated: true)
              }
            }
            self!.loginModel.getProfileData(token: loginAccess)
          }
        }
        alert.addAction(okAction)
        self.present(alert,animated: true, completion: nil)
      }
    } onError: { error in
      DispatchQueue.main.async {
        self.disableView.isHidden = false
        self.indicatorLoading.stopAnimating()
        self.indicatorLoading.isHidden = true
        let alert = UIAlertController(title: "Login Failed!", message: error.capitalized, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
      }
    }
    
    
  }
  
  // MARK: Check Validation For Text Field
  @objc func checkValidation() {
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
}
