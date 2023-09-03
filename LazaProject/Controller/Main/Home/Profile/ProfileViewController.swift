//
//  UserViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 29/07/23.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
  
  // MARK: Label
  @IBOutlet weak var myProfile: UILabel!{
    didSet { myProfile.font = UIFont(name: "Poppins-SemiBold", size: 28)}
  }
  
  @IBOutlet weak var nameTtl: UILabel!{
    didSet { nameTtl.font = UIFont(name: "Poppins-Regular", size: 17)}
  }
  
  @IBOutlet weak var usernameTtl: UILabel!{
    didSet { usernameTtl.font = UIFont(name: "Poppins-Regular", size: 17)}
  }
  
  @IBOutlet weak var usernameLbl: UILabel!{
    didSet {
      usernameLbl.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var emailTtl: UILabel!{
    didSet { emailTtl.font = UIFont(name: "Poppins-Regular", size: 17)}
  }
  
  @IBOutlet weak var emailLbl: UILabel!{
    didSet { emailLbl.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  // MARK: Image
  @IBOutlet weak var profileImage: UIImageView!
  
  // MARK: Button
  @IBOutlet weak var editProfile: UIButton!{
    didSet { editProfile.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBarItemImage()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    UserModel.synchronize()
    let data = UserDefaults.standard
    nameLabel.text = data.string(forKey: "fullname")
    usernameLbl.text = data.string(forKey: "username")
    emailLbl.text = data.string(forKey: "email")
    let imageURL = URL(string: data.string(forKey: "image") ?? "")
    profileImage.sd_setImage(with: imageURL)
  }
  
  // MARK: Setup BarItem when Clicked Change into Text
  private func setupTabBarItemImage() {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    label.text = "Home"
    label.font = UIFont(name: "Inter-Medium", size: 11)
    label.sizeToFit()
    
    tabBarItem.standardAppearance?.selectionIndicatorTintColor = UIColor(named: "PurpleButton")
    tabBarItem.selectedImage = UIImage(view: label)
  }
  
  @IBAction func editProfileClicked(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "UpdateProfileViewController", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "UpdateProfileViewController") as? UpdateProfileViewController else { return }
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true)
  }
}
