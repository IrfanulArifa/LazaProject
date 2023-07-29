//
//  SignUpViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class SignUpViewController: UIViewController {
  
  let viewModel = ViewModel()
  
  @IBOutlet weak var usernameTxtField: UITextField!
  @IBOutlet weak var passwordTxtField: UITextField!
  @IBOutlet weak var emailAddressTxtField: UITextField!
  @IBOutlet weak var firstnameTxtField: UITextField!
  @IBOutlet weak var lastnameTxtField: UITextField!
  @IBOutlet weak var phonenumberTxtField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: Back Button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: SignUp Button when Clicked -> Go to Wellcome View
  @IBAction func signUpButtonClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
}
