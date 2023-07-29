//
//  StartedViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit
import FacebookLogin

class StartedViewController: UIViewController {
  
  // MARK: Font Setting Type
  @IBOutlet weak var startedTitleTxt: UILabel!{
    didSet{ startedTitleTxt.font = UIFont(name: "Inter", size: 28) }
  }
  
  override func viewDidLoad() { super.viewDidLoad() }
  
  @IBAction func facebookButtonClicked(_ sender: Any) {
    let loginManager = LoginManager()
    loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in
      if error != nil {
        print("ERROR: Trying to get login results")
      } else if result?.isCancelled != nil {
        print("The token is \(result?.token?.tokenString ?? "")")
        if result?.token?.tokenString != nil {
          print("Logged in")
          //                        self.getUserProfile(token: result?.token, userId: result?.token?.userID)
        } else {
          print("Cancelled")
        }
      }
    })
  }
  // MARK: Create Button When Clicked -> Change to SignUp View
  @IBAction func CreateAccBtnClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "SignUpViewController", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: SignIn Button When Clicked -> Change to Welcome View
  @IBAction func signInBtnClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  // MARK: Back Button When Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}
