import Foundation
import RxSwift

class FlickrApiRequest: NetworkRequestProviding {
    
    func getPhotos(for latitude: Double, longitude: Double) -> Observable<Response> {
        let flickrResource = FlickrResource(latitude: latitude, longitude: longitude)
        guard let flickrUrlRequest = createURLRequest(from: flickrResource) else {
            return Observable.error(NSError(domain: "de.shunya", code: 666, userInfo: nil))
        }
        return post(request: flickrUrlRequest)
    }
    
    func get(request: NSMutableURLRequest) -> Observable<Response> {
        return dataTask(request: request)
    }
    
    func post(request: NSMutableURLRequest) -> Observable<Response> {
        return dataTask(request: request)
    }
    
    func createURLRequest<T>(from resource: T) -> NSMutableURLRequest? where T : ApiResourceProviding {
        
        guard let baseUrl = URL(string:self.baseUrl) else {
            return nil
        }
        let flickrRequest = NSMutableURLRequest(url:baseUrl,
                                                cachePolicy: .returnCacheDataElseLoad,
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
