import Foundation
import CoreLocation

// CoreLocation extenstion for protocol conformance
extension CLLocationManager: LocationManagerConfigurable {
    func setDelegate(to instance: CLLocationManagerDelegate?) {
        guard let delegate = instance else {
            return
        }
        self.delegate = delegate
    }
    // Changed this because CLLocationAccuracy is just a typealias for Double
    func setDesiredAccuracy(to accuracy: CLLocationAccuracy) {
        self.desiredAccuracy = accuracy
    }
}
