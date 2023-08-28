//
//  DetailViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 27/07/23.
//

import UIKit
import SDWebImage
import SnackBar

class DetailViewController: UIViewController {
  
  // MARK: Get Welcome Element Data
  var dataDetail: Int?
  let viewModel = DetailViewModel()
  var sizeProduct: Int?
  
  @IBOutlet weak var detailTableView: IntrinsicTableView!
  @IBOutlet weak var wishlistButton: UIButton!{
    didSet {
      wishlistButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    detailTableView.delegate = self
    detailTableView.dataSource = self
    
    detailTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
    detailTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil),forCellReuseIdentifier: "ReviewTableViewCell")
    
    
    viewModel.loadDetail(dataDetail!)
    let token = UserDefaults.standard.string(forKey: "access_token")
    viewModel.isInWishlist(token: token!)
    
    viewModel.reloadDetail = {
      DispatchQueue.main.async {
        self.detailTableView.reloadData()
      }
    }
    
    viewModel.reloadWishlist = {
      self.checkWhistlist()
    }
  }
  
  // MARK: Function that Configure Data from Collection into DetailView
  func configure(data: Int) {
    dataDetail = data
  }
  
  // MARK: Back button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
  
  
  // MARK: Function that Set Star Image Style from RatingValue in API
  override func viewDidAppear(_ animated: Bool) {
    detailTableView.reloadData()
  }
  
  func checkWhistlist() {
    guard let range = viewModel.wishlistData?.data.total else { return }
    
    if range == 0 {
      resetWishlistImage()
    } else {
      for i in 0..<range{
        if viewModel.wishlistData?.data.products[i].id == dataDetail {
          setWishlistImage()
          break
        } else {
          resetWishlistImage()
        }
      }
    }
  }
  
  func setWishlistImage() {
    DispatchQueue.main.async {
      self.wishlistButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
  }
  
  func resetWishlistImage() {
    DispatchQueue.main.async {
      self.wishlistButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
  }
  
  @IBAction func wishlistButton(_ sender: UIButton) {
    let tokenAcc = UserDefaults.standard.string(forKey: "access_token")
    viewModel.putWishlist(productId: String(dataDetail!), token: tokenAcc!) { response in
      if response?.data == "successfully added wishlist" {
        DispatchQueue.main.async {
          validSnackBar.make(in: self.view, message: (response?.data.capitalized)!, duration: .lengthLong).show()
          self.setWishlistImage()
        }
      } else if response?.data == "successfully delete wishlist" {
        DispatchQueue.main.async {
          invalidSnackBar.make(in: self.view, message: (response?.data.capitalized)!, duration: .lengthLong).show()
          self.resetWishlistImage()
        }
      }
    } onError: { error in
      DispatchQueue.main.async {
        invalidSnackBar.make(in: self.view, message: error.capitalized, duration: .lengthLong).show()
      }
    }
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
  func sizeClicked(_ collectionView: UICollectionView, _ didSelectItemAt: IndexPath) {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizeCollectionViewCell", for: didSelectItemAt) as? SizeCollectionViewCell else { return }
    sizeProduct = cell.sizeId
  }
  
  
  func actionClicked() {
    let storyboard = UIStoryboard(name: "ReviewViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
    guard let id = dataDetail else { return }
    vc.getProductId(product: id)
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true)
  }
}
