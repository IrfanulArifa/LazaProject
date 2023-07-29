//
//  StartedViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class StartedViewController: UIViewController {
  
  // MARK: Font Setting Type
  @IBOutlet weak var startedTitleTxt: UILabel!{
    didSet{ startedTitleTxt.font = UIFont(name: "Inter", size: 28) }
  }
  
  override func viewDidLoad() { super.viewDidLoad() }
  
  // MARK: Create Button When Clicked -> Change to SignUp View
  @IBAction func CreateAccBtnClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "SignUpViewController", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: SignIn Button When Clicked -> Change to Welcome View
  @IBAction func signInBtnClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "WelcomeViewController", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: Back Button When Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}
