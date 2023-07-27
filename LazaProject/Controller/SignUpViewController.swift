//
//  SignUpViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  
  @IBAction func signUpButtonClicked(_ sender: Any) {
    let storyboard = UIStoryboard(name: "WelcomeViewController", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
    self.navigationItem.title = ""
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
}
