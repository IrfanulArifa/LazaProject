//
//  UpdatePasswordViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 30/07/23.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
  
  let viewModel = ViewModel()
  var validEmailTxt = false
  var validPasswordTxt = false
  var validNumberTxt = false
  var validFirstNameTxt = false
  var validLastNameTxt = false
  var userNameTxt = false
  
  @IBOutlet weak var usernameTf: UITextField!
  
  @IBOutlet weak var passwordTf: UITextField!{
    didSet {
      passwordTf.isSecureTextEntry = true
    }
  }
  
  @IBOutlet weak var emailTf: UITextField!
  @IBOutlet weak var firstNameTf: UITextField!
  @IBOutlet weak var lastNameTf: UITextField!
  @IBOutlet weak var phoneNumberTf: UITextField!
  
  @IBOutlet weak var validUsernameImage: UIImageView!{
    didSet {
      validUsernameImage.isHidden = true
    }
  }
  
  @IBOutlet weak var validPasswordImage: UILabel!{
    didSet {
      validPasswordImage.isHidden = true
    }
  }
  
  @IBOutlet weak var validEmailImage: UIImageView!{
    didSet {
      validEmailImage.isHidden = true
    }
  }
  
  @IBOutlet weak var validFirstNameImage: UIImageView!{
    didSet {
      validFirstNameImage.isHidden = true
    }
  }
  
  @IBOutlet weak var validLastNameImage: UIImageView!{
    didSet {
      validLastNameImage.isHidden = true
    }
  }
  
  @IBOutlet weak var validPhoneNumberImage: UIImageView!{
    didSet {
      validPhoneNumberImage.isHidden = true
    }
  }
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    UserModel.synchronize()
    usernameTf.text = UserDefaults.standard.string(forKey: "name")
    passwordTf.text = UserDefaults.standard.string(forKey: "password")
    emailTf.text = UserDefaults.standard.string(forKey: "email")
    firstNameTf.text = UserDefaults.standard.string(forKey: "firstname")
    lastNameTf.text = UserDefaults.standard.string(forKey: "lastname")
    phoneNumberTf.text = UserDefaults.standard.string(forKey: "phonenumber")
    
    passwordTf.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    emailTf.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    phoneNumberTf.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    usernameTf.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    firstNameTf.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
    lastNameTf.addTarget(self, action: #selector(checkValidation), for: .editingChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    UserModel.synchronize()
    usernameTf.text = UserDefaults.standard.string(forKey: "name")
    passwordTf.text = UserDefaults.standard.string(forKey: "password")
    emailTf.text = UserDefaults.standard.string(forKey: "email")
    firstNameTf.text = UserDefaults.standard.string(forKey: "firstname")
    lastNameTf.text = UserDefaults.standard.string(forKey: "lastname")
    phoneNumberTf.text = UserDefaults.standard.string(forKey: "phonenumber")
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func updateClicked(_ sender: Any) {
    if ( validEmailTxt && validNumberTxt && validPasswordTxt && validNumberTxt && validFirstNameTxt && validLastNameTxt ) {
      viewModel.saveProfil(name: usernameTf.text!, email: emailTf.text!, firstname: firstNameTf.text!, lastname: lastNameTf.text!, phonenumber: phoneNumberTf.text!, password: passwordTf.text!)
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  @objc func checkValidation() {
    validPasswordTxt = passwordTf.validPassword(passwordTf.text ?? "")
    validEmailTxt = emailTf.validEmail(emailTf.text ?? "")
    validNumberTxt = phoneNumberTf.validNumber(phoneNumberTf.text ?? "")
    validFirstNameTxt = firstNameTf.text !=  ""
    validLastNameTxt = lastNameTf.text != ""
    userNameTxt = usernameTf.text != ""
    
    if validEmailTxt {
      validEmailImage.isHidden = false
    }
    if validPasswordTxt {
      validPasswordImage.isHidden = false
      
    }
    if validNumberTxt {
      validPhoneNumberImage.isHidden = false
    }
    
    if validFirstNameTxt {
      validFirstNameImage.isHidden = false
    }
    
    if validLastNameTxt {
      validLastNameImage.isHidden = false
    }
    
    if userNameTxt {
      validUsernameImage.isHidden = false
    }
  }
}
