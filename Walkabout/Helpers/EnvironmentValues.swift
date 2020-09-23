//
//  EnvironmentValues.swift
//  Walkabout
//
//  Created by Sam Khawase on 18.09.20.
//  Copyright © 2020 de.shunya. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
