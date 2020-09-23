import Foundation
import Combine

protocol NetworkRequestProviding {
    
    // The model that the request deals with
    associatedtype SerializedType : Codable
    
    // Observable CRUD interface
    func get(request: NSMutableURLRequest) ->  AnyPublisher<SerializedType, Error>
    func post(request: NSMutableURLRequest) -> AnyPublisher<SerializedType, Error>
    // optional func put(request: NSMutableURLRequest) -> AnyPublisher<SerializedType>
    // optional func delete(request: NSMutableURLRequest) -> AnyPublisher<SerializedType>
    
    // Internal workhorse function: implemented in default extension
    func dataTask(request: NSMutableURLRequest) -> AnyPublisher<SerializedType, Error>
    
    // The implementor needs to implement this to provide the ApiResource that the request needs
    func createURLRequest<T: ApiResourceProviding>(from resource: T) -> NSMutableURLRequest?
}
