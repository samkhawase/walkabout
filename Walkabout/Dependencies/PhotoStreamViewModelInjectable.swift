import Foundation
import CoreLocation

struct InjectionMap {
    static var locationManager: LocationManagerConfigurable = CLLocationManager()
    static var flickrRequest: FlickrApiRequest = FlickrApiRequest()
    static var locationProvider: LocationProvidable = LocationProvider(locationManager: locationManager,
                                                   distanceFilter: 100,
                                                   allowsBackgroundLocationUpdates: true,
                                                   pausesLocationUpdatesAutomatically: false)
}

protocol PhotoStreamViewModelInjectable { }

extension PhotoStreamViewModelInjectable {
    var locationManager:LocationManagerConfigurable { get { return InjectionMap.locationManager }}
    var flickrRequest: FlickrApiRequest { get { return InjectionMap.flickrRequest }}
    var locationProvider: LocationProvidable { get { return InjectionMap.locationProvider }}
}
