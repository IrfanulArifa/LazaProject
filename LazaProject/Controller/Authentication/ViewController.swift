//
//  ViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit
import FacebookLogin
import Swifter
import GoogleSignInSwift
import GoogleSignIn

class ViewController: UIViewController {
  
  //  var swifter: Swifter!
  var accToken: Credential.OAuthAccessToken?
  var googleSignIn = GIDSignIn.sharedInstance
  
  
  // MARK: View Settings -> Change Font Type
  @IBOutlet weak var startedTitleTxt: UILabel!{
    didSet{ startedTitleTxt.font = UIFont(name: "Poppins-SemiBold", size: 28) }
  }
  @IBOutlet weak var facebookButton: UIButton!{
    didSet { facebookButton.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 17) }
  }
  
  @IBOutlet weak var twitterButton: UIButton!{
    didSet { twitterButton.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 17)}
  }
  
  @IBOutlet weak var googleButton: UIButton!{
    didSet { googleButton.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 17)}
  }
  
  @IBOutlet weak var alreadyTxt: UILabel!{
    didSet { alreadyTxt.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  @IBOutlet weak var signInButton: UIButton!{
    didSet { signInButton.titleLabel!.font = UIFont(name: "Poppins-SemiBold", size: 15)}
  }
  
  @IBOutlet weak var createAccountButton: UIButton!{
    didSet { createAccountButton.titleLabel!.font = UIFont(name: "Poppins-Regular", size: 15)}
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // State for user if login or not.
    if UserDefaults.standard.bool(forKey: "state"){
      if UserDefaults.standard.bool(forKey: "new_user") {
        
      }
      goToHome()
    }
  }
  
  func goToHome() {
    let storyboard = UIStoryboard(name: "HomepageViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func goToSignUp () {
    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  func goToLogin () {
    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  func handleSignInButton() {
    GIDSignIn.sharedInstance.signIn(
      withPresenting: self) { signInResult, error in
        guard signInResult != nil else {
          // Inspect error
          return
        }
      }
  }
  
  @IBAction func facebookButtonClicked(_ sender: UIButton) {
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
  
  @IBAction func twitterButtonClicked(_ sender: UIButton) {
    let swifter = Swifter(consumerKey: TwitterConstants.CONSUMER_KEY, consumerSecret: TwitterConstants.CONSUMER_SECRET_KEY)
    swifter.authorize(withCallback: URL(string: TwitterConstants.CALLBACK_URL)!, presentingFrom: self, success: { accessToken, _ in
      self.accToken = accessToken
      //            self.getUserProfile()
    }, failure: { error in
      print("ERROR: Trying to authorize - \(error)")
    })
  }
  
  @IBAction func googleButtonClicked(_ sender: UIButton) {
    handleSignInButton()
  }
  
  @IBAction func signInButtonClicked(_ sender: UIButton) {
    goToLogin()
  }
  
  @IBAction func createAccountClicked(_ sender: UIButton) {
    goToSignUp()
  }
}
