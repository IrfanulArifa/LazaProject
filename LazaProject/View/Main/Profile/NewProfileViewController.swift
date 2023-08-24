//
//  NewProfileViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 23/08/23.
//

import UIKit

class NewProfileViewController: UIViewController {
  
  // MARK: Label
  @IBOutlet weak var titleLabel: UILabel!{
    didSet { titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 28)}
  }
  
  @IBOutlet weak var subtitleLbl: UILabel!{
    didSet { subtitleLbl.font = UIFont(name: "Poppins-Regular", size: 17)}
  }
  
  @IBOutlet weak var fullnameLbl: UILabel!{
    didSet { fullnameLbl.font = UIFont(name: "Poppins-Regular", size: 14)}
  }
  
  // MARK: Text Field
  @IBOutlet weak var fullnameTF: UITextField!{
    didSet { fullnameTF.font = UIFont(name: "Poppins-Regular", size: 13)}
  }
  
  // MARK: Button
  @IBOutlet weak var DoneBtn: UIButton!{
    didSet { DoneBtn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    let token = UserDefaults.standard.string(forKey: "access_token")
//    let email = UserDefaults.standard.string(forKey: "email")
//    let username = UserDefaults.standard.string(forKey: "username")
  }
}
