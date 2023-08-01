//
//  HomepageViewController.swift
//  LazaProject
//
//  Created by Irfanul Arifa on 26/07/23.
//

import UIKit
import SDWebImage
import SideMenu


class HomepageViewController: UIViewController {
  // MARK: Assign View Model
  let viewModel = ViewModel()
  
  @IBOutlet weak var homeTableView: UITableView!
  
  @IBOutlet weak var searchBarStyle: UISearchBar!{
    didSet{ searchBarStyle.searchBarStyle = .minimal } // Change Bar Style to Minimal
  }
  
  // MARK: Connecting Collection into View
  @IBOutlet weak var categoryTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    categoryTableView.dataSource = self
    categoryTableView.delegate = self
    categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    categoryTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "")
    
    
    // Closure that Reload Collection Data
    viewModel.reloadProduct = {
      DispatchQueue.main.async {
        print("Product Reload")
        self.categoryTableView.reloadData()
      }
    }
    // Closure that Reload Collection Data
    viewModel.reloadCategory = {
      DispatchQueue.main.async {
        print("Category Reload")
        self.categoryTableView.reloadData()
      }
    }
    
    // Load Data From API
    viewModel.loadData()
    
    
    
    // Setup Tab Bar item Function Calling
    setupTabBarItemImage()
  }
  
  // Making a Function that Transform TabBar when Clicked from Logo into Text
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
  
  @objc func sideMenuPressed() {
    let storyboard = UIStoryboard(name: "HomepageViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "SideMenuViewController")
    let sideMenuNav = SideMenuNavigationController(rootViewController: vc)
    navigationController?.present(sideMenuNav, animated: true)
  }
}

// MARK: Extension that Counting DataSource
extension HomepageViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Masuk Pak Eko")
    if indexPath.row < 1 {
      guard let cellA = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as? CategoryTableViewCell else { return UITableViewCell() }
      cellA.configure(viewModel.welcome)
      print("Pak ekonya disini")
      return cellA
    } else {
      guard let cellB = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else { return UITableViewCell() }
      cellB.configuring(viewModel.welcomeElement)
      print(viewModel.welcomeElement.count)
      print("Masukknya kesini")
      return cellB
    }
    //    if indexPath.section == 0 {
    
    //    }
    //
    
    //      return UITableViewCell()
  }
}

extension HomepageViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
}



//extension HomepageViewController: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    // Choosing which one Collection will assign the Value
////    if collectionView == self.categoryCollection {
////      return viewModel.welcome.count // return Welcome data Count
////    }
////    return viewModel.welcomeElement.count // return Welcome Element Data Count
//  }

// MARK: Extension that Set the Item for Collection View
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

// Choosing which one Collection will assign the Value
//    if collectionView == self.categoryCollection {
//      // dequeue Cell
//      guard let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
//      // Call welcome Data
//      let category = viewModel.welcome[indexPath.item]
//      // Set the Cell View from Welcome Data
//      cellA.categoryTxt.text = category.capitalized
//      return cellA // Returning Cell Data into Collection
//    } else {
//      // dequeue Cell
//      guard let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
//      // Call Welcome Element Data
//      let product = viewModel.welcomeElement[indexPath.item]
//      // Set the Cell View from Welcome Element Data
//      cellB.productName.text = product.title
//      let imageURL = product.image // Assign Data From API into new Constant
//      cellB.productImage.sd_setImage(with: URL(string:imageURL)) // Convert variable into URL, download image with SDWebImage Package
//      cellB.productPrice.text = String(product.price)
//      return cellB // Returning Cell data into Collection
//    }
//  }
//
//
//}

// MARK: For Collection Delegate
//extension HomepageViewController: UICollectionViewDelegate {
////  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////
////    // Choosing which one Collection will assign the Value
//////    if collectionView == self.productCollection {
//////      let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
//////      guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
//////      vc.configure(data: viewModel.welcomeElement[indexPath.item]) // Value Configuration from Collection to Detail View
//////      navigationController?.pushViewController(vc, animated: true)
//////    }
////  }
//}

// MARK: Flowlayout Setting
//extension HomepageViewController: UICollectionViewDelegateFlowLayout {
////  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////
////    // Choosing which one Collection will assign the Value
//////    if collectionView == categoryCollection {
//////      return CGSize(width: 150, height: 50) // Set the Width and Height for Category
//////    }
//////    return CGSize(width: 165, height: 300) // Set the Width and Height for Product
////  }
//
////  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
////
////    // Choosing which one Collection will assign the Value
//////    if collectionView == categoryCollection {
//////      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // UIEdgeInset
//////    }
//////    return UIEdgeInsets(top: 0, left: 00, bottom: 0, right: 0) // UIEdgeInset
////  }
//
////  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
////
////    // Choosing which one Collection will assign the Value
//////    if collectionView == categoryCollection {
//////      return 10 // For Category
//////    }
//////    return 20 // For Product
////  }
//}


