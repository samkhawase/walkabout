import Foundation
import CoreLocation

protocol LocationManagerConfigurable {
    // wrap var delegate and desiredAccuracy to keep it platform agnostic
    func setDelegate(to instance: CLLocationManagerDelegate?)
    func setDesiredAccuracy(to accuracy: CLLocationAccuracy)
    func requestAlwaysAuthorization()
    func startUpdatingLocation()
    
    var distanceFilter: Double {get set}
    var allowsBackgroundLocationUpdates: Bool {get set}
    var pausesLocationUpdatesAutomatically: Bool {get set}
    
}

