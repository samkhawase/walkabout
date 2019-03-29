import Foundation
import RxSwift

class MockFlickrRequest: FlickrApiRequest {
    let testJson = """
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
        """.data(using: String.Encoding.utf8)
    
    
}
