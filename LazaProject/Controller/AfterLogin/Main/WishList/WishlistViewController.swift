//
//  WishlistViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 27/07/23.
//

import UIKit

class WishlistViewController: UIViewController {
  
  let viewModel = ViewModel()
  
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
    viewModel.loadData()
    
    viewModel.reloadProduct = {
      DispatchQueue.main.async {
        self.wishlistCollection.reloadData()
      }
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
  
}

extension WishlistViewController: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.welcomeElement.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let data = viewModel.welcomeElement[indexPath.item]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
    let image = URL(string: data.image)
    cell.productImage.sd_setImage(with: image)
    cell.productName.text = data.title
    cell.productPrice.text = String(data.price)
    return cell
  }
  
  
}
