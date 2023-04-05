//
//  ApiHandler.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/3/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
    case noData
    case otherError(Error)
    
    var message: String {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .requestFailed:
                return "Request failed"
            case .invalidResponse:
                return "Invalid response"
            case .decodingError:
                return "Decoding error"
            case .noData:
                return "No Data"
            case .otherError(let error):
                return error.localizedDescription
            }
        }
}

class APIHandler{
    static let shared: APIHandler = APIHandler()
    
    func fetchAPI(url: URL, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        print("calling api")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data")
                completion(.failure(.noData))
                return
            }
            print("there is data")
            completion(.success(data))
        }.resume()
    }
}
