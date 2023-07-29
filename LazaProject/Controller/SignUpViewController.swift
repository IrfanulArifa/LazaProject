//
//  SignUpViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class SignUpViewController: UIViewController {
  
  override func viewDidLoad() { super.viewDidLoad() }
  
  // MARK: Back Button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: SignUp Button when Clicked -> Go to Wellcome View
  @IBAction func signUpButtonClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "WelcomeViewController", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
}
