//
//  PhotoStreamViewModel.swift
//  Walkabout
//
//  Created by Saurabh Khawase on 29.03.19.
//  Copyright © 2019 de.shunya. All rights reserved.
//

import Foundation
import Combine

class PhotoStreamViewModel: PhotoStreamViewModelConfirming, LocationObservable, PhotoStreamViewModelInjectable {
    @Published private(set) var photos: [Photo] = []
    @Published var shouldStartPhotoStream: Bool = false
    
    private var response: AnyPublisher<Response, Error>?
    private var cancellableSink: AnyCancellable?
    
    init() {
        defer {
            self.locationProvider.setListener(listener: self)
            self.locationProvider.startLocationUpdates()
        }
    }
    
    func startPhotoStream() {
        shouldStartPhotoStream = true
    }
    
    func stopPhotoStream() {
        shouldStartPhotoStream = false
        DispatchQueue.main.async {
            self.cancellableSink?.cancel()
        }
    }
    
    func setCurrentLocation(latitude: Double, longitude: Double) {
        if shouldStartPhotoStream {
            self.response = flickrRequest.getPhotos(for: latitude, longitude: longitude)
            guard let response = self.response else { return }
            
            self.cancellableSink = response
                .subscribe(on: DispatchQueue.global())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    print(".sink() received the completion", String(describing: completion))
                    switch completion {
                    case .finished:
                        break
                    case .failure(let anError):
                        print("received error: ", anError)
                    }
                }, receiveValue: { someValue in
                    print(".sink() received \(someValue)")
                    guard let randomPhoto = someValue.photos.randomElement() else {
                        return
                    }
                    self.photos.append(randomPhoto)
                })
        }
    }
}

