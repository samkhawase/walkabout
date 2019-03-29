import XCTest
import Quick
import Nimble

class LocationProviderTests: QuickSpec {
    override func spec() {
        describe("Given a LocationProvider") {
            context("When it's started with LocationManager", closure: {
                // Arrange
                let mockLocationManager = MockLocationManager()
                let mockLocationObservable = MockLocationObservable()
                let locationProvider: LocationProvidable = LocationProvider(locationManager: mockLocationManager,
                                                                            distanceFilter: 100,
                                                                            allowsBackgroundLocationUpdates: true,
                                                                            pausesLocationUpdatesAutomatically: false)
                locationProvider.setListener(listener: mockLocationObservable)
                beforeEach {
                    mockLocationManager.callCount = 0
                    locationProvider.startLocationUpdates()
                }
                it("then starts location updates", closure: {
                    // Act: locationProvider.startLocationUpdates() are already kickstarted in teh beforeEach() section
                    //Assert
                    expect(mockLocationManager.callCount).toEventually(equal(4))
                    expect(mockLocationObservable.coordinates).toEventuallyNot(beNil())
                    expect(mockLocationObservable.coordinates?.0).toEventually(equal(52.51631))
                    expect(mockLocationObservable.coordinates?.1).toEventually(equal(13.37777))
                })
                
                it("then provides current location", closure: {
                    // Act
                    let (lat, lon) = locationProvider.getCurrentLocation()
                    //Assert
                    expect(lat).toEventually(equal(52.51631))
                    expect(lon).toEventually(equal(13.37777))
                })
            })
        }
    }
}
