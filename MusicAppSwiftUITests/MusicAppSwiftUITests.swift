//
//  MusicAppSwiftUITests.swift
//  MusicAppSwiftUITests
//
//  Created by   ST on 4/3/23.
//

import XCTest
import Foundation
@testable import MusicAppSwiftUI

final class MusicAppSwiftUITests: XCTestCase {
    var apiHandler: APIHandler!
    var listViewModel: ListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiHandler = APIHandler.shared
        listViewModel = ListViewModel()
    }

    override func tearDownWithError() throws {
        apiHandler = nil
        listViewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchApi(){
        //given
        let expectation = XCTestExpectation(description: "Fetch API")
        
        let url = API.searchURL(for: "Justin Bieber")
        apiHandler.fetchAPI(url: url){ (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
               // XCTAssertEqual(result.resultCount, -8)
                XCTAssertNotNil(data)
                
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            
        }
        
        let urlEmtpy = API.searchURL(for: " ")
        apiHandler.fetchAPI(url: urlEmtpy){ (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
               // XCTAssertEqual(result.resultCount, -8)
                XCTAssertNotNil(data)
                
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        let urlRandom = API.searchURL(for: "oaihusjfaisjfnasfkbasfbafasfasfbahfsbhaf ")
        apiHandler.fetchAPI(url: urlRandom){ (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
               // XCTAssertEqual(result.resultCount, -8)
                XCTAssertNotNil(data)
                
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
    }

    
    func testGetSongDataSuccess(){
        //let expectation = XCTestExpectation(description: "Fetch song data")
        let songOrArtist = "Taylor Swift"
//        let songResult = SongResult(resultCount: 1, results: [Song(artistID: nil, collectionID: nil, trackID: 123, artistName: "Artist 1", collectionName: nil, trackName: "Track 1", previewURL: nil, artworkUrl30: nil, artworkUrl60: nil, artworkUrl100: nil, collectionPrice: nil, trackPrice: nil, releaseDate: nil, country: nil, currency: nil)])
//        do {
//            let mockedResult = try JSONEncoder().encode(songResult)
//        }catch {
//            XCTFail("Cannot ecode")
//        }
        
        
        var completionCalled = false
        listViewModel.getSongData(for: songOrArtist){
        
            completionCalled = true
        }
        
        //XCTAssertTrue(completionCalled)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
