//
//  DetailViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 27/07/23.
//

import UIKit
import SDWebImage
import SnackBar
import JWTDecode

class DetailViewController: UIViewController {
  
  // MARK: Get Welcome Element Data
  var dataDetail: Int?
  let detailModel = DetailViewModel()
  var sizeProduct: Int?
  let cartModel = CartViewModel()
  let refreshModel = RefreshTokenViewModel()
  let wishlistModel = WishlistViewModel()
  
  @IBOutlet weak var detailTableView: IntrinsicTableView!
  @IBOutlet weak var wishlistButton: UIButton!{
    didSet {
      wishlistButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarController?.tabBar.isHidden = true
    
    detailTableView.delegate = self
    detailTableView.dataSource = self
    
    detailTableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
    detailTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil),forCellReuseIdentifier: "ReviewTableViewCell")
    refreshModel.refreshToken()
    setup()
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    detailTableView.refreshControl = refreshControl
  }
  
  // MARK: Function that Configure Data from Collection into DetailView
  func configure(data: Int) {
    dataDetail = data
  }
  
  @objc func refreshTableView(){
    detailTableView.refreshControl?.endRefreshing()
    setup()
  }
  
  func setup() {
    DispatchQueue.main.async { [weak self] in
      let token = UserDefaults.standard.string(forKey: "access_token")
      guard let self = self else { return }
      self.detailModel.reloadDetail = {
        DispatchQueue.main.async {
          self.detailTableView.reloadData()
        }
      }
      wishlistModel.reloadWishlist = {
        self.checkWhistlist()
      }
      
      detailModel.loadDetail(dataDetail!)
      wishlistModel.getWishlist(token: token!)
    }
  }
  
  // MARK: Back button when Clicked -> Back to Previous View
  @IBAction func backButtonClicked(_ sender: UIButton) {
    refreshModel.refreshToken()
    self.navigationController?.popViewController(animated: true)
  }
  
  
  // MARK: Reload Access Token
  override func viewWillAppear(_ animated: Bool) {
    refreshModel.refreshToken()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    refreshModel.refreshToken()
  }
  
  func checkWhistlist() {
    guard let range = wishlistModel.wishlistData?.data.total else { return }
    
    if range == 0 {
      resetWishlistImage()
    } else {
      for i in 0..<range{
        if wishlistModel.wishlistData?.data.products[i].id == dataDetail {
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
    detailModel.putWishlist(productId: String(dataDetail!), token: tokenAcc!) { response in
      if response?.data == "successfully added wishlist" {
        DispatchQueue.main.async { [unowned self] in
          validSnackBar.make(in: self.view, message: (response?.data.capitalized)!, duration: .lengthLong).show()
          self.setWishlistImage()
        }
      } else if response?.data == "successfully delete wishlist" {
        DispatchQueue.main.async { [unowned self] in
          invalidSnackBar.make(in: self.view, message: (response?.data.capitalized)!, duration: .lengthLong).show()
          self.resetWishlistImage()
        }
      }
    } onError: { error in
      DispatchQueue.main.async { [unowned self] in
        invalidSnackBar.make(in: self.view, message: error.capitalized, duration: .lengthLong).show()
      }
    }
  }
  
  @IBAction func addToCard(_ sender: UIButton) {
    let token = UserDefaults.standard.string(forKey: "access_token")
    let productID = detailModel.detailData?.data.id
    if sizeProduct != nil {
      cartModel.insertCartData(token: token!, productID: productID!, sizeID: sizeProduct!) { response in
        DispatchQueue.main.async {
          validSnackBar.make(in: self.view, message: "Produk Berhasil Ditambahkan", duration: .lengthLong).show()
        }
      } onError: { error in
        DispatchQueue.main.async {
          invalidSnackBar.make(in: self.view, message: error.capitalized, duration: .lengthLong).show()
        }
      }
    } else {
      invalidSnackBar.make(in: self.view, message: "Harap Pilih Size Terlebih Dahulu", duration: .lengthLong).show()
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
      
      guard let data = detailModel.detailData?.data else { return UITableViewCell() }
      let imageURL = data.imageURL
      cellA.imageDetail.sd_setImage(with: URL(string: imageURL))
      cellA.priceDetailLabel.text = "Rp. " + String(data.price)
      cellA.descriptionDetail.text = data.description
      cellA.productNameDetailLabel.text = data.name
      cellA.configureSize(sizes: data.size)
      return cellA
      
    } else {
      
      guard let cellB = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell else { return UITableViewCell()}
      guard let data = detailModel.detailData?.data else { return UITableViewCell() }
      let dateData = DateTimeUtils().formatReview(date: data.reviews[indexPath.row-1].createdAt)
      let dataCell = data.reviews[indexPath.row-1]
      cellB.reviewDate.text = dateData
      cellB.reviewDescription.text = dataCell.comment
      cellB.reviewerName.text = dataCell.fullName
      cellB.reviewerValue.text = String(dataCell.rating)
      cellB.reviewerImage.sd_setImage(with: URL(string: dataCell.imageURL))
      cellB.setRatingImage(dataCell.rating, cellB.star1, cellB.star2, cellB.star3, cellB.star4, cellB.star5)
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
  func sizeUnclicked(_ collectionView: UICollectionView, _ didDeselectItemAt: IndexPath) {
    sizeProduct = detailModel.detailData?.data.size[didDeselectItemAt.item].id
    guard let cell = collectionView.cellForItem(at: didDeselectItemAt) as? SizeCollectionViewCell else { return }
    cell.sizeBackground.backgroundColor = UIColor(named: "sizeColor")
  }
  
  func sizeClicked(_ collectionView: UICollectionView, _ didSelectItemAt: IndexPath) {
    sizeProduct = detailModel.detailData?.data.size[didSelectItemAt.item].id
    guard let cell = collectionView.cellForItem(at: didSelectItemAt) as? SizeCollectionViewCell else { return }
    cell.sizeBackground.backgroundColor = UIColor(named: "PurpleButton")
  }
  
  
  func actionClicked() {
    let storyboard = UIStoryboard(name: "Review", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
    guard let id = dataDetail else { return }
    vc.getProductId(product: id)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
