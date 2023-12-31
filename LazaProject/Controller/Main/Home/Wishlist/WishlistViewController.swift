//
//  WishlistViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 27/07/23.
//

import UIKit

class WishlistViewController: UIViewController {
  
  let viewModel = DetailViewModel()
  let wishlistModel = WishlistViewModel()
  let refreshModel = RefreshTokenViewModel()
  
  @IBOutlet weak var wishlistCollection: UICollectionView!{
    didSet {
      wishlistCollection.delegate = self
      wishlistCollection.dataSource = self
      
      wishlistCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBarItemImage() // Calling Function
    self.tabBarController?.tabBar.isHidden = false
    let token = UserDefaults.standard.string(forKey: "access_token")
    refreshModel.refreshToken()
    DispatchQueue.main.async{ [weak self] in
      self?.reloadWishlist(token: token!)
    }
  }
  
  private func reloadWishlist(token: String){
    wishlistModel.getWishlist(token: token)
    
    wishlistModel.reloadWishlist = {
      DispatchQueue.main.async {
        self.wishlistCollection.reloadData()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
    let token = UserDefaults.standard.string(forKey: "access_token")
    refreshModel.refreshToken()
    DispatchQueue.main.async{ [weak self] in
      self?.reloadWishlist(token: token!)
    }
  }
  
  // MARK: Setup BarItem when Clicked Change into Text
  private func setupTabBarItemImage() {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    label.text = "Wishlist"
    label.font = UIFont(name: "Inter-Medium", size: 11)
    label.textColor = UIColor(named: "PurpleButton")
    label.sizeToFit()
    
    tabBarItem.standardAppearance?.selectionIndicatorTintColor = UIColor(named: "PurpleButton")
    tabBarItem.selectedImage = UIImage(view: label)
  }
  
  
}

extension WishlistViewController: UICollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Detail", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
    vc.configure(data: (wishlistModel.wishlistData?.data.products[indexPath.item].id)!)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

extension WishlistViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return wishlistModel.wishlistData?.data.total ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = wishlistModel.wishlistData?.data.products[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
    let image = URL(string: data!.imageURL)
    cell.productImage.sd_setImage(with: image)
    cell.productName.text = data?.name
    cell.productPrice.text = "Rp. "+String(data!.price)
    return cell
  }
  
  
}

extension WishlistViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 165, height: 300)
  }
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
}
