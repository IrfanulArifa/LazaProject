//
//  DetailViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 27/07/23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
  
  // MARK: Get Welcome Element Data
  var dataDetail: Int?
  let viewModel = DetailViewModel()
  
  @IBOutlet weak var detailTableView: IntrinsicTableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    detailTableView.delegate = self
    detailTableView.dataSource = self
    
    detailTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
    detailTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil),forCellReuseIdentifier: "ReviewTableViewCell")
    
    
    viewModel.loadDetail(dataDetail!)
    
    viewModel.reloadDetail = {
      DispatchQueue.main.async {
        self.detailTableView.reloadData()
      }
    }
  }
  
  // MARK: Function that Configure Data from Collection into DetailView
  func configure(data: Int) {
    dataDetail = data
  }
  
  // MARK: Back button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  
  // MARK: Function that Set Star Image Style from RatingValue in API
  override func viewDidAppear(_ animated: Bool) {
    detailTableView.reloadData()
  }
  
}

extension DetailViewController : UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row < 1 {
      guard let cellA = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as? DetailTableViewCell else { return UITableViewCell() }
      cellA.delegate = self
      
      guard let data = viewModel.detailData?.data else { return UITableViewCell() }
      let imageURL = data.imageURL
      cellA.imageDetail.sd_setImage(with: URL(string: imageURL))
      cellA.priceDetailLabel.text = "Rp. " + String(data.price)
      cellA.descriptionDetail.text = data.description
      cellA.productNameDetailLabel.text = data.name
      cellA.configureSize(sizes: data.size)
      return cellA
      
    } else {
      
      guard let cellB = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell else { return UITableViewCell()}
      guard let data = viewModel.detailData?.data else { return UITableViewCell() }
      let dateData = DateTimeUtils().formatReview(date: data.reviews[indexPath.row-1].createdAt)
      let dataCell = data.reviews[indexPath.row-1]
      cellB.reviewDate.text = dateData
      cellB.reviewDescription.text = dataCell.comment
      cellB.reviewerName.text = dataCell.fullName
      cellB.reviewerValue.text = String(dataCell.rating)
      cellB.setRatingImage(dataCell.rating)
      return cellB
    }
  }
}

extension DetailViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row < 1 {
      return UITableView.automaticDimension
    } else {
      return UITableView.automaticDimension
    }
  }
}

extension DetailViewController: ReviewTableViewCellDelegate {
  
  func actionClicked() {
    let storyboard = UIStoryboard(name: "ReviewViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
    guard let data = viewModel.reviewData else { return }
    guard let id = dataDetail else { return }
    vc.getProductId(product: id)
    vc.sendProductReviewId(data: data)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
