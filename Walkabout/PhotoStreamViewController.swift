//
//  ViewController.swift
//  Walkabout
//
//  Created by Saurabh Khawase on 29.03.19.
//  Copyright © 2019 de.shunya. All rights reserved.
//

import UIKit
import CoreLocation
import Kingfisher

class PhotoStreamViewController: UIViewController, PhotoStreamViewModelObserving {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    private(set) lazy var viewModel:PhotoStreamViewModelConfirming = {
        let _vm = PhotoStreamViewModel(locationProvider: locationProvider, observer: self, flickrRequest: flickrRequest)
        return _vm
    }()
    private(set) lazy var locationProvider: LocationProvidable = {
        let _locationProvider = LocationProvider(locationManager: locationManager,
                                                 distanceFilter: 100,
                                                 allowsBackgroundLocationUpdates: true,
                                                 pausesLocationUpdatesAutomatically: false)
        return _locationProvider
    }()
    
    private(set) lazy var locationManager: LocationManagerConfigurable = {
        let _clLocationManager = CLLocationManager()
        return _clLocationManager
    }()
    
    private(set) lazy var flickrRequest: FlickrApiRequest = {
        let _flickrRequest = FlickrApiRequest()
        return _flickrRequest
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.dataSource = self
        viewModel.getAvailablePhotos()
    }
    func updateCollection(latitude: Double, longitude: Double) {
        DispatchQueue.main.async { [weak self] in
            self?.photosCollectionView.reloadData()
        }
    }
}
extension PhotoStreamViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell
            else { return UICollectionViewCell() }
        let photoForIndex = viewModel.photos[indexPath.item]
        let photoUrl = URL(string: photoForIndex.photoUrl)
        cell.photoImageView.kf.setImage(with: photoUrl)
        cell.photoCaption.text = photoForIndex.title
        return cell

    }
}

