import XCTest
import Quick
import Nimble
import CoreLocation
//import OHHTTPStubs

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
            
            let viewModel = PhotoStreamViewModel()
            it("updates the photo stream for the observer", closure: {
                //viewModel.getAvailablePhotos()
                viewModel.startPhotoStream()
                expect(viewModel.shouldStartPhotoStream).toEventually(beTrue())
                viewModel.stopPhotoStream()
                expect(viewModel.shouldStartPhotoStream).toEventually(beFalse())
            })
        }
    }
}
