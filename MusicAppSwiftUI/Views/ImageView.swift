//
//  ImageView.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/3/23.
//

import SwiftUI
import UIKit

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    var placeholder: UIImage

    init(withURL url: URL?, placeholder: UIImage = UIImage(named: "music-note")!, cache: NSCache<NSURL, UIImage>?) {
        
        imageLoader = ImageLoader(cache: cache)
        self.placeholder = placeholder
        
        if let url = url {
            imageLoader.loadImage(from: url)
        }
    }

    var body: some View {
        if let uiImage = imageLoader.image {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            Image(uiImage: placeholder)
                .resizable()
                .scaledToFit()
        }
    }
}


struct ImageView_Previews: PreviewProvider {
    static let cache = NSCache<NSURL,UIImage>()

    static var previews: some View {
        ImageView(withURL: URL(string: "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/11/7c/3e/117c3e65-6e6e-74e3-282e-b2d364cc10d5/mzi.evfewjhl.jpg/100x100bb.jpg")!, cache: cache)
    }
}





