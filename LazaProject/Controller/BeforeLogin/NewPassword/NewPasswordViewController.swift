//
//  NewPasswordViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class NewPasswordViewController: UIViewController {
  
  @IBOutlet weak var newPassword: UILabel!{
    didSet { newPassword.font = UIFont(name: "Poppins-SemiBold", size: 28)}
  }
  
  @IBOutlet weak var passwordTitle: UILabel!{
    didSet { passwordTitle.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var passwordTxtField: UITextField!{
    didSet { passwordTxtField.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var confirmPassword: UILabel!{
    didSet { confirmPassword.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var confirmPasswordTxtField: UITextField!{
    didSet { confirmPasswordTxtField.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var pleaseWrite: UILabel!{
    didSet { pleaseWrite.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  @IBOutlet weak var resetPassword: UIButton!{
    didSet { resetPassword.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  override func viewDidLoad() { super.viewDidLoad() }
  
  // MARK: Back Button Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: Reset Password Clicked -> Go To Welcome View
  @IBAction func resetPasswordClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
}
