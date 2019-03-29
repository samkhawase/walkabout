import Foundation

protocol ApiResourceProviding {
    var baseUrl: String {get set}
    var data: Data { get }
    var headers:Dictionary<String, String> { get }
}
