import Foundation

protocol PhotoStreamViewModelConfirming {
    var photos: [Photo] { get }
    func getAvailablePhotos()
}

protocol PhotoStreamViewModelObserving {
    func updateCollection(latitude: Double, longitude: Double)
}
