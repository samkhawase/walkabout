import XCTest
import CoreLocation
import Mocker
import Combine

class ApiClientTests: XCTestCase {
    let flickrRequest = FlickrApiRequest()
    private var response: AnyPublisher<Response, Error>?
    private var cancellableSink: AnyCancellable?
    
    let configuration = URLSessionConfiguration.default
    var sessionManager: URLSession?

    
    override func setUp() {
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        sessionManager = URLSession(configuration: configuration)
        
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
                preconditionFailure("Could not load data")
        }
        let testHostURL = URL(string:"api.flickr.com/services/rest")!

        let mock = Mock(url: testHostURL, dataType: .json, statusCode: 200, data: [
            .post: jsonData
        ])
        mock.register()

    }
    func testFlickrRequest() {
        // Arrange
        var successFlag = false
        var locations: [Photo] = []
        let expectation = XCTestExpectation(description: "expectation that network request will succeed")
        
        //Act
        response = flickrRequest.getPhotos(for: 52.51631, longitude: 13.37777)

        cancellableSink = response!
                .subscribe(on: DispatchQueue.global())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    print(".sink() received the completion", String(describing: completion))
                    switch completion {
                    case .finished:
                        print("finished")
                        successFlag = true
                        expectation.fulfill()
                        break
                    case .failure(let anError):
                        successFlag = false
                        print("received error: ", anError)
                    }
                }, receiveValue: { someValue in
                    print(".onNext() received \(someValue.photos.count)")
                    locations = someValue.photos
                })
        wait(for: [expectation], timeout: 5.0)
        //Assert
        XCTAssert(successFlag)
        XCTAssert(locations.count == 1)
        
    }
}


