import Foundation
import RxSwift
import RxCocoa

extension NetworkRequestProviding {
    internal var baseUrl: String {
        let _baseUrl = "https://api.flickr.com/services/rest"
        return _baseUrl
    }
    
    func dataTask(request: NSMutableURLRequest) -> Observable<SerializedType> {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        return Observable.create { observer in
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                if let data = data,
                    let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode,
                    let serverResponse = try? decoder.decode(SerializedType.self, from: data) {
                    observer.onNext(serverResponse as SerializedType)
                } else {
                    observer.onError(NSError(domain: "de.shunya.app.Spazieren", code: 999, userInfo: nil))
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
//let json = try? JSONSerialization.jsonObject(with: data) as? [String: String]
