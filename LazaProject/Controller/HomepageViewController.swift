//
//  HomepageViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit
import SDWebImage

class HomepageViewController: UIViewController {
  let viewModel = ViewModel()
  
  @IBOutlet weak var categoryCollection: UICollectionView!
  @IBOutlet weak var productCollection: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.loadCategories()
    viewModel.reloadCategory = {
      DispatchQueue.main.async {
        self.categoryCollection.reloadData()
      }
    }
    
    viewModel.reloadProduct = {
      DispatchQueue.main.async {
        self.productCollection.reloadData()
      }
    }
    
    categoryCollection.dataSource = self
    categoryCollection.delegate = self
    categoryCollection.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    
    productCollection.dataSource = self
    productCollection.delegate = self
    productCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    setupTabBarItemImage()
  }
  
  private func setupTabBarItemImage() {
      let label = UILabel()
      label.numberOfLines = 1
      label.textAlignment = .center
      label.text = "Home"
      label.font = UIFont(name: "Inter-Medium", size: 11)
      label.sizeToFit()
      
      tabBarItem.standardAppearance?.selectionIndicatorTintColor = UIColor(named: "PurpleButton")
      tabBarItem.selectedImage = UIImage(view: label)
  }
}

extension HomepageViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == self.categoryCollection {
      return viewModel.welcome.count
    }
    return viewModel.welcomeElement.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == self.categoryCollection {
      guard let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
      let category = viewModel.welcome[indexPath.item]
      cellA.categoryTxt.text = category.capitalized
      return cellA
    } else {
      guard let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
      let product = viewModel.welcomeElement[indexPath.item]
      cellB.productName.text = product.title
      let imageURL = product.image
      cellB.productImage.sd_setImage(with: URL(string:imageURL))
      cellB.productPrice.text = String(product.price)
      return cellB
    }
  }
  
  
}

extension HomepageViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == self.productCollection {
      let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
      guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
      vc.configure(data: viewModel.welcomeElement[indexPath.item])
      
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}

extension HomepageViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == categoryCollection {
      return CGSize(width: 150, height: 50)
    }
    return CGSize(width: 165, height: 300)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if collectionView == categoryCollection {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    return UIEdgeInsets(top: 0, left: 00, bottom: 0, right: 0)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    if collectionView == categoryCollection {
      return 10
    }
    return 20
  }
}
