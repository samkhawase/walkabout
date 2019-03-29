import CoreLocation

class LocationProvider: NSObject, LocationProvidable, CLLocationManagerDelegate {
    var distanceFilter: Double
    var allowsBackgroundLocationUpdates: Bool
    var pausesLocationUpdatesAutomatically: Bool
    var listener: LocationObservable?
    
    func setListener(listener: LocationObservable) {
        self.listener = listener
    }
    
    fileprivate var locationManager: LocationManagerConfigurable
    fileprivate var currentLocation: CLLocation?
    //fileprivate var observer: LocationObservable?
    
    // inject
    init(locationManager:LocationManagerConfigurable,
         distanceFilter: Double,
         allowsBackgroundLocationUpdates: Bool,
         pausesLocationUpdatesAutomatically: Bool){
        self.locationManager = locationManager
        self.distanceFilter = distanceFilter
        self.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates
        self.pausesLocationUpdatesAutomatically = pausesLocationUpdatesAutomatically
    }
    
    func startLocationUpdates() {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.setDelegate(to: self)
            locationManager.setDesiredAccuracy(to: kCLLocationAccuracyBest)
            locationManager.distanceFilter = distanceFilter
            locationManager.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates
            locationManager.pausesLocationUpdatesAutomatically = pausesLocationUpdatesAutomatically
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func getCurrentLocation() -> (Double, Double) {
        guard let currentLocation = currentLocation else {
            return (0,0)
        }
        return (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
    }
    
    // CLLocationManager delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last,
            let listener = self.listener else {
                return
        }
        
        if currentLocation != nil && Double((currentLocation?.distance(from: lastLocation))!) < 100.0 {
            //print("current Location \(String(describing: currentLocation?.coordinate)) is same as last Location: \(String(describing: lastLocation.coordinate))")
            return
        }
        
        currentLocation = lastLocation
        listener.setCurrentLocation(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
    }
}
