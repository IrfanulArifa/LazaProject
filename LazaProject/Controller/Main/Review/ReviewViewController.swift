//
//  ReviewViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 03/08/23.
//

import UIKit

class ReviewViewController: UIViewController {
  
  @IBOutlet weak var reviewTableView:UITableView!
  
  var idReview: ReviewData?
  var productId: Int?
  let viewModel = DetailViewModel()
  
  @IBOutlet weak var ratingAverage: UILabel!
  @IBOutlet weak var totalReview: UILabel!
  @IBOutlet weak var star1: UIImageView!
  @IBOutlet weak var star2: UIImageView!
  @IBOutlet weak var star3: UIImageView!
  @IBOutlet weak var star4: UIImageView!
  @IBOutlet weak var star5: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    reviewTableView.dataSource = self
    reviewTableView.delegate = self
    
    reviewTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier:"ReviewTableViewCell")
    
    loadReview()
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    reviewTableView.refreshControl = refreshControl
  }
  
  func loadReview() {
    viewModel.reloadReview = {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.reviewTableView.reloadData()
        self.ratingAverage.text = String((self.viewModel.reviewData?.data.ratingAvrg)!)
        self.totalReview.text = String((self.viewModel.reviewData?.data.total)!) + " Reviews"
        self.setRatingImageInReview((self.viewModel.reviewData?.data.ratingAvrg)!)
      }
    }
    viewModel.loadReview(productId!)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    loadReview()
  }
  
  @objc func refreshTableView(){
    reviewTableView.refreshControl?.endRefreshing()
    loadReview()
  }
  
  func getProductId(product: Int){
    productId = product
  }
  
  func setRatingImageInReview(_ value: Double){
    let imageFull = UIImage(systemName: "star.fill")
    let imageHalf = UIImage(systemName: "star.leadinghalf.filled")
    let imageEmpty = UIImage(systemName: "star")
    
    if value == 5 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageFull
      star5.image = imageFull
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemYellow
      star4.tintColor = .systemYellow
      star5.tintColor = .systemYellow
    } else if value == 4 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageFull
      star5.image = imageEmpty
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemYellow
      star4.tintColor = .systemYellow
      star5.tintColor = .systemGray
    } else if value == 3 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemYellow
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value == 2 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value == 1 {
      star1.image = imageFull
      star2.image = imageEmpty
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemGray
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value == 0 {
      star1.image = imageEmpty
      star2.image = imageEmpty
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = .systemGray
      star2.tintColor = .systemGray
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value > 4 && value < 5 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageFull
      star5.image = imageHalf
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemYellow
      star4.tintColor = .systemYellow
      star5.tintColor = .systemYellow
    } else if value > 3 && value < 4 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageFull
      star4.image = imageHalf
      star5.image = imageEmpty
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemYellow
      star4.tintColor = .systemYellow
      star5.tintColor = .systemGray
    } else if value > 2 && value < 3 {
      star1.image = imageFull
      star2.image = imageFull
      star3.image = imageHalf
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemYellow
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value > 1 && value < 2 {
      star1.image = imageFull
      star2.image = imageHalf
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemYellow
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    } else if value > 0 && value < 1 {
      star1.image = imageHalf
      star2.image = imageEmpty
      star3.image = imageEmpty
      star4.image = imageEmpty
      star5.image = imageEmpty
      
      star1.tintColor = .systemYellow
      star2.tintColor = .systemGray
      star3.tintColor = .systemGray
      star4.tintColor = .systemGray
      star5.tintColor = .systemGray
    }
  }
  
}

extension ReviewViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.reviewData?.data.total ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
    let data = viewModel.reviewData?.data.reviews[indexPath.row]
    if let newData = data {
      let time = DateTimeUtils().formatReview(date: data!.createdAt)
      cell.reviewDate.text = time
      cell.reviewDescription.text = newData.comment
      cell.reviewerName.text = newData.fullName
      cell.reviewerValue.text = "\(newData.rating)"
      cell.setRatingImage(newData.rating)
    }
    return cell
  }
  
  @IBAction func addReviewClicked(_ sender: UIButton){
    let storyboard = UIStoryboard(name: "AddReviewViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "AddReviewViewController") as! AddReviewViewController
    guard let id = productId else { return }
    vc.sendProductId(productId: id)
    self.navigationController?.pushViewController(vc, animated: true)
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
