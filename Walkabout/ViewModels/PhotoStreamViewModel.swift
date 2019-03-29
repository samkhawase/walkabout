//
//  PhotoStreamViewModel.swift
//  Walkabout
//
//  Created by Saurabh Khawase on 29.03.19.
//  Copyright © 2019 de.shunya. All rights reserved.
//

import Foundation
import RxSwift

// This class gets it's dependencies injected through the PhotoStreamViewModelInjectable protocol
class PhotoStreamViewModel: PhotoStreamViewModelConfirming, LocationObservable, PhotoStreamViewModelInjectable {
    var photos: [Photo] = []
    let observer: PhotoStreamViewModelObserving
    private let networkQueue = DispatchQueue(label: "in.b3rl.networkQueue")
    private let disposeBag = DisposeBag()
    internal var shouldFetchPhotos: Bool = false
    
    init(observer: PhotoStreamViewModelObserving) {
        self.observer = observer
        defer {
            self.locationProvider.setListener(listener: self)
            self.locationProvider.startLocationUpdates()
        }
    }

    func startPhotoStream() {
        shouldFetchPhotos = true
    }
    func stopPhotoStream() {
        shouldFetchPhotos = false
    }
    
    //
    func setCurrentLocation(latitude: Double, longitude: Double) {
        if shouldFetchPhotos {
            _ = flickrRequest.getPhotos(for: latitude, longitude: longitude)
                .subscribeOn(ConcurrentDispatchQueueScheduler(queue: networkQueue))
                .subscribe(onNext: {[weak self] (response) in
                    guard let photo = response.photos.randomElement() else {
                        return
                    }
                    self?.photos.append(photo)
                    self?.observer.updateCollection(latitude: latitude, longitude: longitude)
                }, onError: { (error) in
                        print("error in flickrRequest.getPhotos(): \(error.localizedDescription)")
                }, onCompleted: {
                    print("Completed flickrRequest.getPhotos() ")
                }) {
                    print("Disposed flickrRequest.getPhotos() ")
                }.disposed(by: disposeBag)
        }
    }
}

