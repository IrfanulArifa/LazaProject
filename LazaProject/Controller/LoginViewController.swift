//
//  LoginViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class LoginViewController: UIViewController {
  
  let viewModel = ViewModel()
  
  @IBOutlet weak var usernameTxtField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var validImage: UIImageView!
  @IBOutlet weak var validText: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.loadDataUser()
  }
  
  // MARK: Back Button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: forgot Button when Clicked -> Go To NewPassword View
  @IBAction func forgotPasswordClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "NewPasswordViewController", bundle: nil).instantiateViewController(withIdentifier: "NewPasswordViewController") as! NewPasswordViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: loginButton when Clicked -> Go To HomePage View
  @IBAction func loginButtonClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "HomepageViewController", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @objc func checkValidation() {
    
  }
}
