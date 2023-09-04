//
//  ChangePasswordViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 04/09/23.
//

import UIKit
import SnackBar

protocol accessSideMenuDelegate: AnyObject {
  func accessSideMenu()
}

class ChangePasswordViewController: UIViewController {
  
  weak var delegate: accessSideMenuDelegate?
  let viewModel = ChangePasswordViewModel()
  var oldValid = false
  var newValid = false
  var confirmValid = false
  
  // MARK: Label
  @IBOutlet weak var changePassword: UILabel!{
    didSet {
      changePassword.font = UIFont(name: "Poppins-SemiBold", size: 20)
    }
  }
  
  @IBOutlet weak var oldPassword: UILabel!{
    didSet {
      oldPassword.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var newPassword: UILabel!{
    didSet {
      newPassword.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  @IBOutlet weak var confirmationPassword: UILabel!{
    didSet {
      confirmationPassword.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  // MARK: Text Field
  @IBOutlet weak var oldPasswordTF: UITextField!{
    didSet {
      oldPasswordTF.font = UIFont(name: "Poppins-Regular", size: 13)
      oldPasswordTF.isSecureTextEntry = true
    }
  }
  
  @IBOutlet weak var newPasswordTF: UITextField!{
    didSet {
      newPasswordTF.font = UIFont(name: "Poppins-Regular", size: 13)
      newPasswordTF.isSecureTextEntry = true
    }
  }
  
  @IBOutlet weak var confirmationTF: UITextField!{
    didSet {
      confirmationTF.font = UIFont(name: "Poppins-Regular", size: 13)
      confirmationTF.isSecureTextEntry = true
    }
  }
  
  // MARK: Valid Image
  @IBOutlet weak var oldPasswordValid: UIImageView!{
    didSet {
      oldPasswordValid.isHidden = true
    }
  }
  
  @IBOutlet weak var newPasswordValid: UIImageView!{
    didSet {
      newPasswordValid.isHidden = true
    }
  }
  
  @IBOutlet weak var confirmPasswordValid: UIImageView!{
    didSet {
      confirmPasswordValid.isHidden = true
    }
  }
  
  // MARK: Button
  @IBOutlet weak var oldEye: UIButton!
  @IBOutlet weak var newEye: UIButton!
  @IBOutlet weak var confirmEye: UIButton!
  @IBOutlet weak var save: UIButton!
  
  // MARK: Loading Animation
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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = true
    oldPasswordTF.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    newPasswordTF.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    confirmationTF.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    
  }
  
  private func startingAnimation() {
    self.indicatorLoading.startAnimating()
    self.indicatorLoading.isHidden = false
    self.disableView.isHidden = false
  }
  
  private func hidingAnimation() {
    self.indicatorLoading.stopAnimating()
    self.indicatorLoading.isHidden = true
    self.disableView.isHidden = true
  }
  
  @objc private func checkValidation() {
    let validOldPassword = oldPasswordTF.validPassword(oldPasswordTF.text ?? "")
    let validNewPassword = newPasswordTF.validPassword(newPasswordTF.text ?? "")
    let validConfirmPassword = confirmationTF.validPassword(confirmationTF.text ?? "")
    oldValid = validOldPassword
    newValid = validNewPassword
    confirmValid = validConfirmPassword
    
    if validOldPassword {
      oldPasswordValid.isHidden = false
    } else {
      oldPasswordValid.isHidden = true
    }
    
    if validNewPassword {
      newPasswordValid.isHidden = false
    } else {
      newPasswordValid.isHidden = true
    }
    
    if validConfirmPassword {
      confirmPasswordValid.isHidden = false
    } else {
      confirmPasswordValid.isHidden = true
    }
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    delegate?.accessSideMenu()
  }
  
  @IBAction func oldPasswordClicked(_ sender: UIButton) {
    if oldPasswordTF.isSecureTextEntry {
      oldEye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      oldPasswordTF.isSecureTextEntry = false
    } else if !oldPasswordTF.isSecureTextEntry{
      oldEye.setImage(UIImage(systemName: "eye"), for: .normal)
      oldPasswordTF.isSecureTextEntry = true
    }
  }
  
  @IBAction func newPasswordClicked(_ sender: UIButton) {
    if newPasswordTF.isSecureTextEntry {
      newEye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      newPasswordTF.isSecureTextEntry = false
    } else if !newPasswordTF.isSecureTextEntry{
      newEye.setImage(UIImage(systemName: "eye"), for: .normal)
      newPasswordTF.isSecureTextEntry = true
    }
  }
  
  @IBAction func confirmPasswordClicked(_ sender: UIButton) {
    if confirmationTF.isSecureTextEntry {
      confirmEye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
      confirmationTF.isSecureTextEntry = false
    } else if !confirmationTF.isSecureTextEntry{
      confirmEye.setImage(UIImage(systemName: "eye"), for: .normal)
      confirmationTF.isSecureTextEntry = true
    }
  }
  
  @IBAction func savePasswordClicked(_ sender: UIButton) {
    if oldPasswordTF.text == "" || newPasswordTF.text == "" || confirmationTF.text == "" {
      invalidSnackBar.make(in: view.self , message: "Harap isi Data Terlebih Dahulu", duration: .lengthLong).show()
    } else if !oldValid {
        invalidSnackBar.make(in: view.self , message: "Old Password Tidak Valid", duration: .lengthLong).show()
    } else if !newValid {
      invalidSnackBar.make(in: view.self , message: "New Password Tidak Valid", duration: .lengthLong).show()
    } else if !confirmValid {
      invalidSnackBar.make(in: view.self , message: "Confirm Password Tidak Valid", duration: .lengthLong).show()
    } else {
      savePassword()
    }
  }
  
  func savePassword () {
    let token = UserDefaults.standard.string(forKey: "access_token")
    viewModel.changePassword(token: token!, oldPassword: oldPasswordTF.text!, newPassword: newPasswordTF.text!, confirmPassword: confirmationTF.text!) { response in
      guard let response = response else { return }
      DispatchQueue.main.async { [unowned self] in
        self.showAlert(title: "Change Password", message: "Success") {
          self.navigationController?.popViewController(animated: true)
          self.delegate?.accessSideMenu()
        }
      }
    } onError: { error in
      DispatchQueue.main.async { [unowned self] in
        invalidSnackBar.make(in: self.view, message: error.capitalized, duration: .lengthLong).show()
      }
    }
  }
}
