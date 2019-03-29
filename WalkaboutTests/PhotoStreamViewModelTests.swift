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
            let viewModel = PhotoStreamViewModel(locationProvider: mockLocationProvider,
                                                 observer: mockViewController,
                                                 flickrRequest: mockFlickrRequest)
            it("update the photo stream for the observer", closure: {
                viewModel.getAvailablePhotos()
                expect(mockViewController.successFlag).toEventually(beTrue())
            })
        }
    }
}
