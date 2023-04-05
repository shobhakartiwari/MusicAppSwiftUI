//
//  Extension.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/3/23.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(from url: URL, placeholder: UIImage? = nil, cache: NSCache<NSURL, UIImage>) {
        
        self.image = placeholder
        if let cachedImage = cache.object(forKey: url as NSURL){
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            print("getting image from url")
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data) {
                    cache.setObject(downloadedImage, forKey: url as NSURL)
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
