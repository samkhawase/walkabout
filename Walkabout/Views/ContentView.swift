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
        VStack {
            Toggle(isOn: self.$viewModel.shouldStartPhotoStream) {
                Text("Start photo stream")
                    .font(.subheadline)
            }
            .padding([.leading, .trailing], 20)
            .padding([.bottom, .top], 10)
            Spacer()
            List {
                ForEach(viewModel.photos) { photo in
                    AsyncImage(url: photo.photoUrl,
                               placeholder: Text("Loading ..."),
                               cache: self.cache,
                               configuration: { $0.resizable() })
                        .frame(minHeight: 200, maxHeight: 200)
                        .aspectRatio(contentMode: .fit)
                }
            }
            .onAppear {
             UITableView.appearance().separatorStyle = .none
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PhotoStreamViewModel())
    }
}

