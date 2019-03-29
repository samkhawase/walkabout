import Foundation

protocol LocationProvidable {
    var listener: LocationObservable? { get set }
    func setListener(listener: LocationObservable)
    func startLocationUpdates()
    func getCurrentLocation() -> (Double, Double)
    
    var distanceFilter: Double {get set}
    var allowsBackgroundLocationUpdates: Bool {get set}
    var pausesLocationUpdatesAutomatically: Bool {get set}
}

// to be implemented by the VM
protocol LocationObservable {
    func setCurrentLocation(latitude: Double, longitude: Double)
}
