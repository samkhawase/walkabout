import Foundation

class MockViewController: PhotoStreamViewModelObserving {
    internal var successFlag = false
    func updateCollection(latitude: Double, longitude: Double) {
        successFlag = true
    }
    
}
