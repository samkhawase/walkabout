import Foundation
import Combine

protocol PhotoStreamViewModelConfirming: ObservableObject {
    var photos: [Photo] { get }
    func startPhotoStream()
    func stopPhotoStream()
}

protocol PhotoStreamViewModelObserving {
    func updateCollection(latitude: Double, longitude: Double)
}
