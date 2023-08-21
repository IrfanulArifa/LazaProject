//
//  VerificationCodeViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit
import DPOTPView

class VerificationCodeViewController: UIViewController {
  // MARK: Parameter for timer
  var timeRemaining = 300
  var timer : Timer!
  
  // MARK: Import View Model
  let verificationViewModel = VerificationCodeViewModel()
  let forgetPasswordViewModel = ForgetPasswordViewModel()
  var email: String?
  
  // MARK: Label
  @IBOutlet weak var verificationLbl: UILabel!{
    didSet {
      verificationLbl.font = UIFont(name: "Poppins-SemiBold", size: 28)
    }
  }
  
  @IBOutlet weak var timerLabel: UILabel!{
    didSet {
      timerLabel.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  // MARK: Button
  @IBOutlet weak var resendButton: UIButton!{
    didSet {
      resendButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  @IBOutlet weak var confirmCode: UIButton!{
    didSet {
      confirmCode.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  // MARK: View
  @IBOutlet weak var otpField: DPOTPView!{
    didSet { otpField.cornerRadiusTextField = 10}
  }
  
  func sendEmail(data: String){
    email = data
  }
  @IBOutlet weak var disableView: UIView!{
    didSet { disableView.isHidden = true }
  }
  @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!{
    didSet { indicatorLoading.isHidden = true }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTimer()
    
  }
  
  func setTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
  }
  
  func resetTimer() {
    timer.invalidate()
    timeRemaining = 300
    setTimer()
    
    let minute = timeRemaining / 60
    let sec = timeRemaining % 60
    
    if sec < 10 {
      timerLabel.text = "0\(minute):0\(sec)"
    } else {
      timerLabel.text = "0\(minute):\(sec)"
    }
  }
  
  func validatingOTP(){
    startingAnimation()
    guard let email = email else { return }
    verificationViewModel.verificationToken(email: email, otp: otpField.text!) { response in
      DispatchQueue.main.async {
        self.hidingAnimation()
        self.showAlert(title: "OTP Valid", message: "Redirecting") {
          self.goToNewPassword()
        }
      }
    } onError: { error in
      DispatchQueue.main.async {
        self.hidingAnimation()
        if error == "Key: 'VerificationCode.Email' Error:Field validation for 'Email' failed on the 'required' tag" {
          self.showAlert(title: "Invalid Email", message: "Email is Empty")
        } else if error == "Key: 'VerificationCode.Code' Error:Field validation for 'Code' failed on the 'min' tag" {
          self.showAlert(title: "Invalid OTP", message: "Please Enter valid OTP")
        } else if error == "expired verify email, please resend mail verify again!" {
          self.showAlert(title: "OTP expired", message: error.capitalized)
        }
      }
    }
    
  }
  
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func confirmCode(_ sender: UIButton) {
    validatingOTP()
  }
  
  func goToNewPassword() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "NewPasswordViewController") as! NewPasswordViewController
    vc.sendDataToNPW(email: email!, OTP: otpField.text!)
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func resendOTP() {
    guard let email = email else { return }
    forgetPasswordViewModel.forgotPassword(email: email) { response in
      DispatchQueue.main.async {
        self.showAlert(title: "Success", message: "Please Check your Email Box, \n Redirect to...")
      }
    } onError: { error in
      DispatchQueue.main.async {
        if error == "Key: 'Email.Email' Error:Field validation for 'Email' failed on the 'required' tag" {
          invalidSnackBar.make(in: self.view, message: "Email is Empty!", duration: .lengthLong).show()
        } else if error == "Key: 'Email.Email' Error:Field validation for 'Email' failed on the 'email' tag" {
          invalidSnackBar.make(in: self.view, message: "Invalid Email!", duration: .lengthLong).show()
        } else if error == "please enter a valid email address" {
          invalidSnackBar.make(in: self.view, message: "Invalid Email!", duration: .lengthLong).show()
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
  
  @IBAction func resendButtonClicked(_ sender: UIButton) {
    resetTimer()
    setTimer()
    resendOTP()
  }
  
  @objc func countDown(){
    if timeRemaining > 0 {
      timeRemaining -= 1
    } else {
      timer.invalidate()
      timeRemaining = 300
    }
    
    let minute = timeRemaining / 60
    let sec = timeRemaining % 60
    
    if sec < 10 {
      timerLabel.text = "0\(minute):0\(sec)"
    } else {
      timerLabel.text = "0\(minute):\(sec)"
    }
  }
}
