import XCTest
import Quick
import Nimble
import CoreLocation
import OHHTTPStubs

class PhotoStreamViewModelTests: QuickSpec {
    override func spec() {
        describe("Given a PhotoStreamViewModelTests") {
            let mockLocationManager = MockLocationManager()
            let mockLocationProvider = MockLocationProvider(locationManager: mockLocationManager,
                                                            distanceFilter: 100,
                                                            allowsBackgroundLocationUpdates: true,
                                                            pausesLocationUpdatesAutomatically: false)
            let mockFlickrRequest = MockFlickrRequest()
            let mockViewController = MockViewController()
            
            InjectionMap.locationManager = mockLocationManager
            InjectionMap.flickrRequest = mockFlickrRequest
            InjectionMap.locationProvider = mockLocationProvider
            
            let viewModel = PhotoStreamViewModel(observer: mockViewController)
            it("updates the photo stream for the observer", closure: {
                viewModel.getAvailablePhotos()
                expect(mockViewController.successFlag).toEventually(beTrue())
            })
        }
    }
}
