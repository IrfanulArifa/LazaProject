//
//  StartedViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit

class StartedViewController: UIViewController {

  @IBOutlet weak var startedTitleTxt: UILabel!{
    didSet{
      startedTitleTxt.font = UIFont(name: "Inter", size: 28)
    }
  }
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  @IBAction func CreateAccBtnClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "SignUpViewController", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    self.navigationItem.title = ""
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @IBAction func signInBtnClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "WelcomeViewController", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
    self.navigationItem.title = ""
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}
