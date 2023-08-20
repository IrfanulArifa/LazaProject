//
//  VerificationCodeViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit

class VerificationCodeViewController: UIViewController {
  
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var resendButton: UIButton!
  var timeRemaining = 20
  var timer : Timer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTimer()
  }
  
  func setTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
  }
  
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func confirmCode(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPasswordViewController")
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @IBAction func resendButtonClicked(_ sender: Any) {
    timer.invalidate()
    timeRemaining = 20
    setTimer()
    timerLabel.text = "00:\(timeRemaining)"
  }
  
  @objc func countDown(){
    if timeRemaining > 0 {
      timeRemaining -= 1
    } else {
      timer.invalidate()
      timeRemaining = 20
    }
    timerLabel.text = "00:\(timeRemaining)"
  }
}
