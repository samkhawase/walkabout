//
//  ViewController.swift
//  Walkabout
//
//  Created by Saurabh Khawase on 29.03.19.
//  Copyright © 2019 de.shunya. All rights reserved.
//

//import UIKit
//import CoreLocation
//import Kingfisher
//
//class PhotoStreamViewController: UIViewController, PhotoStreamViewModelObserving {
//    
//    @IBOutlet weak var photosCollectionView: UICollectionView!
//    
//    private(set) lazy var viewModel:PhotoStreamViewModelConfirming = {
//        let _vm = PhotoStreamViewModel(observer: self)
//        return _vm
//    }()
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        photosCollectionView.dataSource = self
//    }
//    @IBAction func startButtonPressed(_ sender: Any) {
//        if let sender = sender as? UIBarButtonItem {
//            switch sender.title {
//            case "Start":
//                viewModel.startPhotoStream()
//                sender.title = "Stop"
//                break
//            case "Stop":
//                viewModel.stopPhotoStream()
//                sender.title = "Start"
//                break
//            default:
//                break
//            }
//        }
//    }
//    func updateCollection(latitude: Double, longitude: Double) {
//        DispatchQueue.main.async { [weak self] in
//            self?.photosCollectionView.reloadData()
//        }
//    }
//}
//extension PhotoStreamViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.photos.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell
//            else { return UICollectionViewCell() }
//        let photoForIndex = viewModel.photos[indexPath.item]
//        let photoUrl = URL(string: photoForIndex.photoUrl)
//        cell.photoImageView.kf.setImage(with: photoUrl)
//        cell.photoCaption.text = photoForIndex.title
//        return cell
//
//    }
//}

