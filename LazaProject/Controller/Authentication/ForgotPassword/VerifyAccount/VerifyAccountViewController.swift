//
//  VerifyAccountViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 19/08/23.
//

import UIKit

class VerifyAccountViewController: UIViewController {
  
  // MARK: Import View Model
  let verifyModel = VerifyAccountViewModel()
  var emailValue : String?
  
  // MARK: Setting Timer
  var timeRemaining = 300
  var timer: Timer!
  
  // MARK: Label
  @IBOutlet weak var verifyLbl: UILabel!{
    didSet { verifyLbl.font = UIFont(name: "Poppins-SemiBold", size: 28) }
  }
  
  @IBOutlet weak var emailLbl: UILabel!{
    didSet { emailLbl.font = UIFont(name: "Poppins-Regular", size: 14) }
  }
  
  @IBOutlet weak var timestampLbl: UILabel!{
    didSet {
      timestampLbl.font = UIFont(name: "Poppins-SemiBold", size: 15)
      timestampLbl.isHidden = true
    }
  }
  
  @IBOutlet weak var pleaseCheck: UILabel! {
    didSet {
      pleaseCheck.font = UIFont(name: "Poppins-Regular", size: 14)
      pleaseCheck.isHidden = true
    }
  }
  
  // MARK: TextField
  @IBOutlet weak var emailTxtField: UITextField!{
    didSet { emailTxtField.font = UIFont(name: "Poppins-Regular", size: 14)}
  }
  
  // MARK: Button
  @IBOutlet weak var backToLogin: UIButton!{
    didSet { backToLogin.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  // MARK: UIImage
  @IBOutlet weak var validImage: UIImageView!{
    didSet { validImage.isHidden = true }
  }
  
  @IBOutlet weak var disableView: UIView!{
    didSet { disableView.isHidden = true }
  }
  @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!{
    didSet { indicatorLoading.isHidden = true }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(true, animated: true)
    setTimer()
    emailTxtField.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
  }
  
  func showTimer() {
    timestampLbl.isHidden = false
    pleaseCheck.isHidden = false
  }
  
  func setTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
  }
  
  @objc private func countDown() {
    if timeRemaining > 0 {
      timeRemaining -= 1
    } else {
      timer.invalidate()
      timeRemaining = 300
    }
    let minute = timeRemaining / 60
    let sec = timeRemaining % 60
    
    if sec < 10 {
      timestampLbl.text = "0\(minute):0\(sec)"
    } else {
      timestampLbl.text = "0\(minute):\(sec)"
    }
  }
  
  func sendVerify() {
    startingAnimation()
    verifyModel.resendVerify(email: emailTxtField.text! ) { response in
      DispatchQueue.main.async { [unowned self] in
        self.hidingAnimation()
        self.showAlert(title: "Verify Resend", message: "Please Check your Email box")
      }
    } onError: { error in
      DispatchQueue.main.async {
        self.hidingAnimation()
        if error == "please enter a valid email address" {
          DispatchQueue.main.async {
            self.showAlert(title: "Invalid Email", message: error.capitalized)
          }
        } else if error == "Key: 'Email.Email' Error:Field validation for 'Email' failed on the 'required' tag" {
          DispatchQueue.main.async {
            self.showAlert(title: "Invalid Email", message: "Please write your Email Address")
          }
        } else {
          DispatchQueue.main.async {
            self.showAlert(title: "Already Registered", message: error.capitalized)
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
  
  @objc private func checkValidation(){
    let isValidEmail = emailTxtField.validEmail(emailTxtField.text ?? "")
    
    if isValidEmail {
      validImage.isHidden = false
    } else {
      validImage.isHidden = true
    }
  }
  
  func resetTimer() {
    timer.invalidate()
    timeRemaining = 300
    setTimer()
    
    let minute = timeRemaining / 60
    let sec = timeRemaining % 60
    
    if sec < 10 {
      timestampLbl.text = "0\(minute):0\(sec)"
    } else {
      timestampLbl.text = "0\(minute):\(sec)"
    }
  }
  
  func goToLogin() {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func resendVerify(_ sender: UIButton) {
    showTimer()
    resetTimer()
    setTimer()
    sendVerify()
  }
  
  @IBAction func backToLogin(_ sender: UIButton) {
    goToLogin()
  }
}
