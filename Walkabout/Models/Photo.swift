import Foundation

class Photo: Codable, Identifiable {
    let farm: Int
    let id, secret, server, title: String
    var photoUrl: URL {
        get {
            guard let _photoURL = URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_c.jpg")
                else {
                    return URL(string: "https://via.placeholder.com/640x480.png?text=Placeholder%20Image")!
            }
            return _photoURL
        }
    }
}
class Response: Codable {
    var photos: [Photo]
    init() {
        photos = []
    }
    enum CodingKeys: String, CodingKey {
        case photos = "photos"  // this is the outer container
        case photo = "photo"    // this is the inner array
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy:CodingKeys.self, forKey: .photos)
        self.photos = try response.decode([Photo].self, forKey: .photo)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        try response.encode(self.photos, forKey: .photo)
    }
}
