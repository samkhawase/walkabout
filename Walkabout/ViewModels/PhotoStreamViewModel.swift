//
//  PhotoStreamViewModel.swift
//  Walkabout
//
//  Created by Saurabh Khawase on 29.03.19.
//  Copyright © 2019 de.shunya. All rights reserved.
//

import Foundation
import RxSwift


class PhotoStreamViewModel: PhotoStreamViewModelConfirming, LocationObservable {
    var photos: [Photo] = []
    
    let locationProvider: LocationProvidable
    let observer: PhotoStreamViewModelObserving
    let flickrRequest: FlickrApiRequest
    private let networkQueue = DispatchQueue(label: "in.b3rl.networkQueue")
    private let disposeBag = DisposeBag()
    
    init(locationProvider: LocationProvidable, observer: PhotoStreamViewModelObserving, flickrRequest: FlickrApiRequest) {
        self.locationProvider = locationProvider
        self.observer = observer
        self.flickrRequest = flickrRequest
        defer {
            self.locationProvider.setListener(listener: self)
            self.locationProvider.startLocationUpdates()
        }
    }
    
    func getAvailablePhotos() {
        observer.updateCollection(latitude: 0, longitude: 0)
    }
    
    //
    func setCurrentLocation(latitude: Double, longitude: Double) {
        print("currentLocation is: \(latitude) : \(longitude)")
        _ = flickrRequest.getPhotos(for: latitude, longitude: longitude)
            .subscribeOn(ConcurrentDispatchQueueScheduler(queue: networkQueue))
            .subscribe(onNext: {[weak self] (response) in
                guard let photo = response.photos.randomElement() else {
                    return
                }
                //print("got new photo: \(photo.title)")
                self?.photos.append(photo)
                self?.observer.updateCollection(latitude: latitude, longitude: longitude)
                }, onError: { (error) in
                    print("error in flickrRequest.getPhotos(): \(error.localizedDescription)")
            }, onCompleted: {
                print("Disposed flickrRequest.getPhotos() ")
            }) {
                
            }.disposed(by: disposeBag)
    }
}

