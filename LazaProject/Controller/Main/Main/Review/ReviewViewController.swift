//
//  ReviewViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 03/08/23.
//

import UIKit

class ReviewViewController: UIViewController {

  @IBOutlet weak var reviewTableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

      reviewTableView.dataSource = self
      reviewTableView.delegate = self
      
      reviewTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier:"ReviewTableViewCell")
    }

}

extension ReviewViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
    cell.reviewDate.text = "11-02-2000"
    cell.reviewDescription.text = "Mantap"
    cell.reviewerName.text = "Udin"
    cell.reviewerValue.text = "3"
    return cell
  }
  
  @IBAction func addReviewClicked(_ sender: UIButton){
    let storyboard = UIStoryboard(name: "AddReviewViewController", bundle: nil).instantiateViewController(withIdentifier: "AddReviewViewController") as! AddReviewViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
  @IBAction func backButtonClicked(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
}

extension ReviewViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
