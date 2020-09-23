import Foundation
import Combine

extension NetworkRequestProviding {
    internal var baseUrl: String {
        let _baseUrl = "https://api.flickr.com/services/rest"
        return _baseUrl
    }
    
    func dataTask(request: NSMutableURLRequest) -> AnyPublisher<SerializedType, Error> {
        let remoteDataPublisher = URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                }
                return element.data
        }
        .decode(type: SerializedType.self, decoder: JSONDecoder())
        .print()
        .eraseToAnyPublisher()
        
        return remoteDataPublisher
    }
}
//let json = try? JSONSerialization.jsonObject(with: data) as? [String: String]
