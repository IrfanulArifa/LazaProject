//
//  SignUpViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit
import SnackBar

class SignUpViewController: UIViewController {
  
  let viewModel = ViewModel()
  let signUp = SignUpViewModel()
  
  var validEmailTxt = false
  var validPasswordTxt = false
  var validConfirmTxt = false
  var userNameTxt = false
  
  @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!{
    didSet { indicatorLoading.isHidden = true}
  }
  @IBOutlet weak var signUpTitle: UILabel!{
    didSet { signUpTitle.font = UIFont(name: "Poppins-SemiBold", size: 28)}
  }
  
  @IBOutlet weak var usernameTitle: UILabel!{
    didSet { usernameTitle.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var usernameTxtField: UITextField!{
    didSet { usernameTxtField.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var passwordTitle: UILabel!{
    didSet { passwordTitle.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var passwordTxtField: UITextField!{
    didSet {
      passwordTxtField.isSecureTextEntry = true
      passwordTxtField.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  
  @IBOutlet weak var confirmPasswordTitle: UILabel!{
    didSet { confirmPasswordTitle.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var confirmPasswordTxtField: UITextField!{
    didSet {
      confirmPasswordTxtField.isSecureTextEntry = true
      confirmPasswordTxtField.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  
  @IBOutlet weak var emailAddressTitle: UILabel!{
    didSet { emailAddressTitle.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  
  @IBOutlet weak var emailAddressTxtField: UITextField!{
    didSet {
      emailAddressTxtField.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
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
  @IBOutlet weak var disableView: UIView!{
    didSet {
      disableView.isHidden = true
    }
  }
  
  @IBOutlet weak var passwordEyeButton: UIButton!
  @IBOutlet weak var confirmPasswordEyeButton: UIButton!
  
  @IBOutlet weak var rememberMe: UILabel!{
    didSet { rememberMe.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var signUpButton: UIButton!{
    didSet { signUpButton.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(true, animated: true)
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
    startingAnimation()
    if passwordTxtField.text == "" || emailAddressTxtField.text == "" || usernameTxtField.text == "" || confirmPasswordTxtField.text == "" {
      hidingAnimation()
      invalidSnackBar.make(in: self.view, message: "Data Kosong", duration: .lengthLong).show()
    } else if !validEmailTxt {
      hidingAnimation()
      invalidSnackBar.make(in: self.view, message: "Email tidak Valid", duration: .lengthLong).show()
    } else if !validPasswordTxt {
      hidingAnimation()
      invalidSnackBar.make(in: self.view, message: "Password Tidak Strong", duration: .lengthLong).show()
    } else if !validConfirmTxt {
      hidingAnimation()
      invalidSnackBar.make(in: self.view, message: "Password Tidak Strong", duration: .lengthLong).show()
    } else if !( passwordTxtField.text == confirmPasswordTxtField.text ) {
      hidingAnimation()
      invalidSnackBar.make(in: self.view, message: "Password Tidak Sama", duration: .lengthLong).show()
    } else if ( validPasswordTxt && validConfirmTxt) && ( passwordTxtField.text == confirmPasswordTxtField.text ) {
      
      signUp.register(fullname: usernameTxtField.text!,
                      username: usernameTxtField.text!,
                      email: emailAddressTxtField.text!,
                      password: passwordTxtField.text!) { response in
        DispatchQueue.main.async {
          self.hidingAnimation()
          self.showAlert(title: "Registration Success", message: "Please Check your Email box") {
            DispatchQueue.main.async { [unowned self] in
              self.goToLogin()
            }
          }
        }
      } onError: { error in
        DispatchQueue.main.async { [unowned self] in
          self.hidingAnimation()
          if error == "username is taken, try another" {
            self.showAlert(title: "Username is Already Use", message: "Redirect to Login...") {
              DispatchQueue.main.async { [unowned self] in
                self.goToLogin()
              }
            }
          } else if error == "email is taken, try another" {
            self.showAlert(title: "Email is Already Use", message: "Redirect to Login..." ){
              DispatchQueue.main.async { [unowned self] in
                self.goToLogin()
              }
            }
          }
        }
      }
    }
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
  
  func goToLogin() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
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
  @objc private func checkValidation(){
    validPasswordTxt = passwordTxtField.validPassword(passwordTxtField.text ?? "")
    validEmailTxt = emailAddressTxtField.validEmail(emailAddressTxtField.text ?? "")
    validConfirmTxt = confirmPasswordTxtField.validPassword(confirmPasswordTxtField.text ?? "")
    let usernameNotNull = usernameTxtField.text ?? ""
    userNameTxt = usernameNotNull.count > 4
    
    if validEmailTxt {
      validEmail.isHidden = false
    } else {
      validEmail.isHidden = true
    }
    
    if userNameTxt {
      validUsername.isHidden = false
    } else {
      validUsername.isHidden = true
    }
  }
}
