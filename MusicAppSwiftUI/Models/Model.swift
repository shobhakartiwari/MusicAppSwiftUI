//
//  Model.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/3/23.
//

import Foundation


// MARK: - Welcome
struct SongResult: Codable {
    let resultCount: Int
    let results: [Song]
}

struct Song: Codable, Identifiable {
    let id = UUID()
    let artistID, collectionID: Int?  
    let trackID: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
 
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    
    let country: Country?
    let currency: Currency?

    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, country, currency
    }
}

enum Explicitness: String, Codable {
    case explicit = "explicit"
    case notExplicit = "notExplicit"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

