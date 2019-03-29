import Foundation
class FlickrResource: ApiResourceProviding {
    
    var baseUrl: String = "https://api.flickr.com/services/rest"
    var data: Data {
        if let _data = "method=\(method)&api_key=\(apiKey)&lat=\(latitude)&lon=\(longitude)&format=json&nojsoncallback=1"
            .data(using: String.Encoding.utf8) {
            return _data
        } else {
            return Data()
        }
    }
    
    var headers: Dictionary<String, String> {
        var _headers = Dictionary<String, String>()
        _headers["Content-Type"] = "application/x-www-form-urlencoded"
        _headers["Access-Control-Allow-Origin"] = "*"
        _headers["Access-Control-Allow-Origin"] = "*/*"
        
        return _headers
    }
    
    private let method = "flickr.photos.search"
    private var apiKey = ""
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double, apiKey: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.apiKey = apiKey
    }
    
}
