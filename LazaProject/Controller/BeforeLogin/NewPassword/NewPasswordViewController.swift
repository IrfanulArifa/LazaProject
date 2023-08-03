//
//  NewPasswordViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class NewPasswordViewController: UIViewController {
  
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
