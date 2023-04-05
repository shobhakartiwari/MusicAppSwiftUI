//
//  ListViewModel.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/3/23.
//

import Foundation
import UIKit
import SwiftUI

enum ViewModelError: Error {
    case networkError(Error)
    case parsingError(Error)
    case invalidDataError
}

class ListViewModel: ObservableObject {
    @Published var songList: [Song] = []
    var error: String = ""
    @Published var imageCache = NSCache<NSURL, UIImage>()
    
    private func decode<T: Decodable>(from data: Data) -> Result<T, ViewModelError> {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
        } catch let error {
            return .failure(.parsingError(error))
        }
    }
    
    func getSongData(for songOrArtist: String, onCompletion: @escaping () -> Void) {
        APIHandler.shared.fetchAPI(url: API.searchURL(for: songOrArtist)) { result in
            switch result {
            case .success(let data):
                let parsedDataResult: Result<SongResult, ViewModelError> = self.decode(from: data)
                switch parsedDataResult {
                case .success(let parsedData):
                    print("hello")
                    
                    DispatchQueue.main.async {
                                       self.songList = parsedData.results
                                   }
                    
                    onCompletion()
                case .failure(let error):
                    print("there is data but cannot decode data")
                    print(error)
                    self.error = error.localizedDescription
                }
            case .failure(let error):
                print("failed to request data")
                self.error = error.localizedDescription
            }
        }
    }
    
    func getNumOfRows() -> Int {
        return songList.count
    }
    func getImageFromCache(imageUrl: String?) -> UIImage{
        guard let urlString = imageUrl else {
            print("no url string in image")
            return UIImage(named: "music-note")!
        }
        guard let url = NSURL(string: urlString), let image =  imageCache.object(forKey: url) else {
            print("uh oh there is url strinb but no cached image found")
            return UIImage(named: "music-note")!
        }
        
        return image
    }
}
