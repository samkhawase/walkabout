//
//  ContentView.swift
//  Walkabout
//
//  Created by Sam Khawase on 18.09.20.
//  Copyright © 2020 de.shunya. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: PhotoStreamViewModel
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        List {
            Toggle(isOn: self.$viewModel.shouldStartPhotoStream) {
                Text("Start photo stream")
                    .font(.subheadline)
            }
            Spacer()
            ForEach(viewModel.photos) { photo in
                AsyncImage(url: photo.photoUrl,
                           placeholder: Text("Loading ..."),
                           cache: self.cache,
                           configuration: { $0.resizable() })
                    .frame(minHeight: 200, maxHeight: 200)
                    .aspectRatio(contentMode: .fit)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PhotoStreamViewModel())
    }
}

