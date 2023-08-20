//
//  VerificationCodeViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 07/08/23.
//

import UIKit
import DPOTPView

class VerificationCodeViewController: UIViewController {
  // MARK: Parameter for timer
  var timeRemaining = 300
  var timer : Timer!
  
  // MARK: Label
  @IBOutlet weak var verificationLbl: UILabel!{
    didSet {
      verificationLbl.font = UIFont(name: "Poppins-SemiBold", size: 28)
    }
  }
  
  @IBOutlet weak var timerLabel: UILabel!{
    didSet {
      timerLabel.font = UIFont(name: "Poppins-SemiBold", size: 17)
    }
  }
  
  // MARK: Button
  @IBOutlet weak var resendButton: UIButton!{
    didSet {
      resendButton.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  @IBOutlet weak var confirmCode: UIButton!{
    didSet {
      confirmCode.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
    }
  }
  
  // MARK: View
  @IBOutlet weak var otpField: DPOTPView!
  
  
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
    let text = otpField.text
    print(text ?? "")
//    let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewPasswordViewController")
//    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @IBAction func resendButtonClicked(_ sender: Any) {
    timer.invalidate()
    timeRemaining = 300
    setTimer()
    
    let minute = timeRemaining / 60
    let sec = timeRemaining % 60
    
    if sec < 10 {
      timerLabel.text = "0\(minute):0\(sec)"
    } else {
      timerLabel.text = "0\(minute):\(sec)"
    }
  }
  
  @objc func countDown(){
    if timeRemaining > 0 {
      timeRemaining -= 1
    } else {
      timer.invalidate()
      timeRemaining = 300
    }
    
    let minute = timeRemaining / 60
    let sec = timeRemaining % 60
    
    if sec < 10 {
      timerLabel.text = "0\(minute):0\(sec)"
    } else {
      timerLabel.text = "0\(minute):\(sec)"
    }
  }
}
