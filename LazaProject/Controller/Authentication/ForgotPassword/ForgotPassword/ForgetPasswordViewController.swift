//
//  ForgetPasswordViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit
import SnackBar

class ForgetPasswordViewController: UIViewController {
  
  // MARK: Import ViewModel
  let forgetViewModel = ForgetPasswordViewModel()
  
  @IBOutlet weak var forgotTxt: UILabel!{
    didSet {
      forgotTxt.font = UIFont(name: "Poppins-SemiBold", size: 28)
    }
  }
  
  @IBOutlet weak var emailAddressTxt: UILabel!{
    didSet {
      emailAddressTxt.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var emailAdressTxtField: UITextField!{
    didSet {
      emailAdressTxtField.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var pleaseWriteEmail: UILabel!{
    didSet {
      pleaseWriteEmail.font = UIFont(name: "Poppins-Regular", size: 13)
    }
  }
  
  @IBOutlet weak var confirmButton: UIButton!{
    didSet {
      confirmButton.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var validImage: UIImageView!{
    didSet {
      validImage.isHidden = true
    }
  }
  @IBOutlet weak var disableView: UIView!{
    didSet { disableView.isHidden = true}
  }
  @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!{
    didSet { indicatorLoading.isHidden = true}
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(true, animated: true)
    emailAdressTxtField.addTarget(self, action: #selector(emailValidation), for: .editingChanged)
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
  
  func goToOTP() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "VerificationCodeViewController") as! VerificationCodeViewController
    vc.sendEmail(data: emailAdressTxtField.text!)
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func confirmMailClicked(_ sender: UIButton) {
    confirmMail()
  }
  
  func confirmMail() {
    startingAnimation()
    forgetViewModel.forgotPassword(email: emailAdressTxtField.text!) { response in
      DispatchQueue.main.async { [unowned self] in
        self.hidingAnimation()
        self.showAlert(title: "Success", message: "Please Check your Email Box \n Redirect to...") {
          self.goToOTP()
        }
      }
    } onError: { error in
      DispatchQueue.main.async { [unowned self] in
        self.hidingAnimation()
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
  
  @objc func emailValidation() {
    let validEmail = emailAdressTxtField.validEmail(emailAdressTxtField.text ?? "")
    if validEmail {
      validImage.isHidden = false
    } else {
      validImage.isHidden = true
    }
  }
}
