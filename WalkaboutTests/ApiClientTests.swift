import XCTest
import CoreLocation
import OHHTTPStubs
import RxSwift

class ApiClientTests: XCTestCase {
    let flickrRequest = FlickrApiRequest()
    func testFlickrRequest() {
        let testHost = "api.flickr.com"
        stub(condition: isHost(testHost), response: { _ in
            guard let jsonData = """
                        {
                          "photos": {
                            "page": 1,
                            "pages": "733078",
                            "perpage": 1,
                            "photo": [
                              {
                                "farm": 8,
                                "id": "33596152888",
                                "isfamily": 0,
                                "isfriend": 0,
                                "ispublic": 1,
                                "owner": "48708043@N00",
                                "secret": "dd3a574ddb",
                                "server": "7819",
                                "title": "Blue In The Face"
                              }
                            ],
                            "total": "733078"
                          },
                          "stat": "ok"
                        }
                       """.data(using: .utf8)
                else {
                        preconditionFailure("Could not find expected file in test bundle")
                }
            return HTTPStubsResponse(data: jsonData, statusCode:200, headers:nil)
        })
        
        // Arrange
        var successFlag = false
        var locations: [Photo] = []
        let expectation = XCTestExpectation(description: "expectation that network request will succeed")
        // Act
        _ = flickrRequest.getPhotos(for: 52.51631, longitude: 13.37777)
            .subscribe(onNext: { response in
                locations = response.photos
            }, onError: { error in
                successFlag = false
            }, onCompleted: {
                successFlag = true
                expectation.fulfill()
            }, onDisposed: {
                successFlag = true
            })
        wait(for: [expectation], timeout: 5.0)
        //Assert
        XCTAssert(successFlag)
        XCTAssert(locations.count == 1)
    }
    override func tearDown() {
        HTTPStubs.removeAllStubs()
    }
}

