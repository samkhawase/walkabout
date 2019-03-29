import Foundation
import RxSwift

typealias CompletionBlock = (_ success: Bool, _ object: AnyObject?) -> ()

protocol NetworkRequestProviding {
    
    // The model that the request deals with
    associatedtype SerializedType : Codable
    
    // Observable CRUD interface
    func get(request: NSMutableURLRequest) -> Observable<SerializedType>
    func post(request: NSMutableURLRequest) -> Observable<SerializedType>
    // optional func put(request: NSMutableURLRequest) -> Observable<SerializedType>
    // optional func delete(request: NSMutableURLRequest) -> Observable<SerializedType>
    
    // Internal workhorse function: implemented in default extension
    func dataTask(request: NSMutableURLRequest) -> Observable<SerializedType>
    
    // The implementor needs to implement this to provide the ApiResource that the request needs
    func createURLRequest<T: ApiResourceProviding>(from resource: T) -> NSMutableURLRequest?
}
