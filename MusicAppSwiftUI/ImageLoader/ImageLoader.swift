//
//  ImageLoader.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/3/23.
//

import Foundation
import UIKit
import Combine


class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var cancellable: AnyCancellable?
    
    private let cache: NSCache<NSURL, UIImage>?
    init(cache: NSCache<NSURL, UIImage>?){
        self.cache = cache
        print("image loader init")
    }
    
    func loadImage(from url: URL) {
        if let cachedImage = cache?.object(forKey: url as NSURL) {
            print("image from cache")
            self.image = cachedImage
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self else { return }
                if let image = image {
                    print("set new image")
                    self.cache?.setObject(image, forKey: url as NSURL)
                }
                self.image = image
            }
    }
    deinit {
        print("image loader deinit")
    }
}
