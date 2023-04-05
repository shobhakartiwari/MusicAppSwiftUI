//
//  Constant.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/3/23.
//

import Foundation

struct API {
    private static let baseUrl = "https://itunes.apple.com"
    private static let path = "/search?term="
    static func searchURL(for songOrArtist: String) -> URL {
        let formattedName = songOrArtist.replacingOccurrences(of: " ", with: "+")
        return URL(string: baseUrl + path + formattedName)!
    }
}



