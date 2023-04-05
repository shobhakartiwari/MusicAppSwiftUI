//
//  ContentView.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/3/23.
//

import SwiftUI


struct SongListView: View {
    @ObservedObject var viewModel: ListViewModel = ListViewModel()
    private weak var playerViewModel: PlayerViewModel?
    
    var body: some View {
        NavigationView{
            List(viewModel.songList) { song in
                NavigationLink(destination: PlayerView(viewModel: PlayerViewModel(song: song, cachedImage: viewModel.getImageFromCache(imageUrl: song.artworkUrl100)))){
                    
                    HStack {
                        ImageView(withURL: URL(string: song.artworkUrl100!), cache: viewModel.imageCache)
                            .frame(width: 70, height: 70)
                        
                 
                        VStack(alignment: .leading) {
                            Text(song.trackName ?? "no name")
                            Text(song.artistName ?? "no name")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }.onAppear {
                viewModel.getSongData(for: "Taylor Swift") {
                }
            }
        }
       
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView()
    }
}
