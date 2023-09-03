//
//  NewPasswordViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class NewPasswordViewController: UIViewController {
  
  // MARK: Variable to get Value from Forget Password
  var emailData: String?
  var otp: String?
  
  // MARK: Import ViewModel
  let viewModel = NewPasswordViewModel()
  
  @IBOutlet weak var newPassword: UILabel!{
    didSet { newPassword.font = UIFont(name: "Poppins-SemiBold", size: 28)}
  }
  
  @IBOutlet weak var passwordTitle: UILabel!{
    didSet { passwordTitle.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var passwordTxtField: UITextField!{
    didSet { passwordTxtField.font = UIFont(name: "Poppins-Regular", size: 13)
      passwordTxtField.isSecureTextEntry = true
    }
  }
  
  @IBOutlet weak var confirmPassword: UILabel!{
    didSet { confirmPassword.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var confirmPasswordTxtField: UITextField!{
    didSet { confirmPasswordTxtField.font = UIFont(name: "Poppins-Regular", size: 13)
      confirmPasswordTxtField.isSecureTextEntry = true
    }
  }
  
  @IBOutlet weak var pleaseWrite: UILabel!{
    didSet { pleaseWrite.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var resetPassword: UIButton!{
    didSet { resetPassword.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  @IBOutlet weak var passwordValid: UIImageView!{
    didSet { passwordValid.isHidden = true }
  }
  
  @IBOutlet weak var confirmPasswordValid: UIImageView! {
    didSet { confirmPasswordValid.isHidden = true }
  }
  
  @IBOutlet weak var eye: UIButton!
  @IBOutlet weak var eyeConfirm: UIButton!
  
  @IBOutlet weak var disableView: UIView! {
    didSet { disableView.isHidden = true }
  }
  @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!{
    didSet { indicatorLoading.isHidden = true }
  }
  
  func sendDataToNPW(email: String, OTP: String) {
    emailData = email
    otp = OTP
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(true, animated: true)
    passwordTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    confirmPasswordTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    
  }
  
  @objc private func checkValidation() {
    let validPassword = passwordTxtField.validPassword(passwordTxtField.text ?? "")
    let validConfirm = confirmPasswordTxtField.validPassword(confirmPasswordTxtField.text ?? "")
    
    if validPassword {
      passwordValid.isHidden = false
    } else {
      passwordValid.isHidden = true
    }
    
    if validConfirm {
      confirmPasswordValid.isHidden = false
    } else {
      confirmPasswordValid.isHidden = true
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
  
  // MARK: Back Button Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  // MARK: Reset Password Clicked -> Go To Welcome View
  @IBAction func resetPasswordClicked(_ sender: UIButton) {
    startingAnimation()
    viewModel.resetPassword(email: emailData!, otpData: otp!, new_password: passwordTxtField.text!, re_password: confirmPasswordTxtField.text!) { response in
      DispatchQueue.main.async {
        guard let response = response?.data.message.capitalized else { return }
        self.hidingAnimation()
        self.showAlert(title: "Reset Password Success", message: response + "\n Redirecting to Login Page..."){
          self.goToLogin()
        }
      }
    } onError: { error in
      self.hidingAnimation()
      self.showAlert(title: "Reset Password Failed", message: error.capitalized)
    }
  }
  
  func goToLogin() {
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  @IBAction func passwordEyeClicked(_ sender: UIButton) {
    if passwordTxtField.isSecureTextEntry {
      eye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      passwordTxtField.isSecureTextEntry = false
    } else if !passwordTxtField.isSecureTextEntry{
      eye.setImage(UIImage(systemName: "eye"), for: .normal)
      passwordTxtField.isSecureTextEntry = true
    }
  }
  
  @IBAction func confirmEyeClicked(_ sender: UIButton) {
    if confirmPasswordTxtField.isSecureTextEntry {
      eyeConfirm.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      confirmPasswordTxtField.isSecureTextEntry = false
    } else if !confirmPasswordTxtField.isSecureTextEntry{
      eyeConfirm.setImage(UIImage(systemName: "eye"), for: .normal)
      confirmPasswordTxtField.isSecureTextEntry = true
    }
  }
}
