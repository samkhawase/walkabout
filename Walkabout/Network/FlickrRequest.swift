import Foundation
import Combine

class FlickrApiRequest: NetworkRequestProviding {
    
    private var response: AnyPublisher<Response, Error>?
    
    func getPhotos(for latitude: Double, longitude: Double) -> AnyPublisher<Response, Error> {
        // get Flickr API key from info.plist
        let currentBundle = Bundle(for: type(of: self))
        guard let apiKey = currentBundle.object(forInfoDictionaryKey: "API_KEY") as? String else {
            return Fail(error: NSError(domain: "de.shunya", code: 666, userInfo: nil))
                .eraseToAnyPublisher()
        }
        // create a Resource to be used to get data
        let flickrResource = FlickrResource(latitude: latitude, longitude: longitude, apiKey: apiKey)
        guard let flickrUrlRequest = createURLRequest(from: flickrResource) else {
            return Fail(error: NSError(domain: "de.shunya", code: 666, userInfo: nil))
                .eraseToAnyPublisher()
        }
        self.response = post(request: flickrUrlRequest)
        return self.response!
    }
    
    func get(request: NSMutableURLRequest) -> AnyPublisher<SerializedType, Error> {
        return dataTask(request: request)
    }
    
    func post(request: NSMutableURLRequest) -> AnyPublisher<SerializedType, Error> {
        return dataTask(request: request)
    }
    
    func createURLRequest<T>(from resource: T) -> NSMutableURLRequest? where T : ApiResourceProviding {
        
        guard let baseUrl = URL(string:self.baseUrl) else {
            return nil
        }
        let flickrRequest = NSMutableURLRequest(url:baseUrl,
                                                cachePolicy: .reloadRevalidatingCacheData,
                                                timeoutInterval: 1.0)
        flickrRequest.httpMethod = "POST"
        
        flickrRequest.httpBody = resource.data
        resource.headers.forEach { (arg) in
            let (key, value) = arg
            flickrRequest.addValue(value, forHTTPHeaderField: key)
        }
        return flickrRequest
    }
    
    typealias SerializedType = Response
    
}
