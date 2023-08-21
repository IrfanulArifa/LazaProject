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
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as? DetailTableViewCell else { return UITableViewCell() }
    cell.delegate = self
    if let data = viewModel.detailData?.data {
      print("Datanya Ini")
      let imageURL = data.imageURL
      cell.imageDetail.sd_setImage(with: URL(string: imageURL))
      cell.priceDetailLabel.text = "Rp. " + String(data.price)
      cell.descriptionDetail.text = data.description
      cell.productNameDetailLabel.text = data.name
//      cell.configureData(data: data.id)
//      cell.configureProductId(dataSize: data.id)
//      cell.reloadData()
  //    cell.descriptionDetail.text = viewModel.description
      
  //    setRatingImage(viewModel.rating.rate)
    }
    
    
    func setRatingImage(_ value: Double){
      if value == 5 {
        cell.star1.image = UIImage(systemName: "star.fill")
        cell.star2.image = UIImage(systemName: "star.fill")
        cell.star3.image = UIImage(systemName: "star.fill")
        cell.star4.image = UIImage(systemName: "star.fill")
        cell.star5.image = UIImage(systemName: "star.fill")
        
        cell.star1.tintColor = .systemYellow
        cell.star2.tintColor = .systemYellow
        cell.star3.tintColor = .systemYellow
        cell.star4.tintColor = .systemYellow
        cell.star5.tintColor = .systemYellow
      } else if value >= 4 && value < 5 {
        cell.star1.image = UIImage(systemName: "star.fill")
        cell.star2.image = UIImage(systemName: "star.fill")
        cell.star3.image = UIImage(systemName: "star.fill")
        cell.star4.image = UIImage(systemName: "star.fill")
        cell.star5.image = UIImage(systemName: "star")
        
        cell.star1.tintColor = .systemYellow
        cell.star2.tintColor = .systemYellow
        cell.star3.tintColor = .systemYellow
        cell.star4.tintColor = .systemYellow
        cell.star5.tintColor = .systemGray
      } else if value >= 3 && value < 4 {
        cell.star1.image = UIImage(systemName: "star.fill")
        cell.star2.image = UIImage(systemName: "star.fill")
        cell.star3.image = UIImage(systemName: "star.fill")
        cell.star4.image = UIImage(systemName: "star")
        cell.star5.image = UIImage(systemName: "star")
        
        cell.star1.tintColor = .systemYellow
        cell.star2.tintColor = .systemYellow
        cell.star3.tintColor = .systemYellow
        cell.star4.tintColor = .systemGray
        cell.star5.tintColor = .systemGray
      } else if value >= 2 && value < 3 {
        cell.star1.image = UIImage(systemName: "star.fill")
        cell.star2.image = UIImage(systemName: "star.fill")
        cell.star3.image = UIImage(systemName: "star")
        cell.star4.image = UIImage(systemName: "star")
        cell.star5.image = UIImage(systemName: "star")
        
        cell.star1.tintColor = .systemYellow
        cell.star2.tintColor = .systemYellow
        cell.star3.tintColor = .systemGray
        cell.star4.tintColor = .systemGray
        cell.star5.tintColor = .systemGray
      } else if value >= 1 && value < 2 {
        cell.star1.image = UIImage(systemName: "star.fill")
        cell.star2.image = UIImage(systemName: "star")
        cell.star3.image = UIImage(systemName: "star")
        cell.star4.image = UIImage(systemName: "star")
        cell.star5.image = UIImage(systemName: "star")
        
        cell.star1.tintColor = .systemYellow
        cell.star2.tintColor = .systemGray
        cell.star3.tintColor = .systemGray
        cell.star4.tintColor = .systemGray
        cell.star5.tintColor = .systemGray
      }
    }
    return cell
  }
}

extension DetailViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension DetailViewController: ReviewTableViewCellDelegate {
  
  func actionClicked() {
    let storyboard = UIStoryboard(name: "ReviewViewController", bundle: nil).instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
    self.navigationController?.pushViewController(storyboard, animated: true)
  }
  
}
