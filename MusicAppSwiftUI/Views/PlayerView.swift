//
//  PlayerView.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/4/23.
//

import SwiftUI
import AVFAudio
import AVFoundation


struct PlayerView: View {
    var viewModel: PlayerViewModel
   // var playPauseButton: Image
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        
    }
    
    @State var sliderValue: Double = 0.5
    @State var sliderMaxValue: Double = 1.0

    var body: some View {
        VStack {            
            ImageView(withURL: nil, placeholder: viewModel.cachedImage, cache: nil)
            Text(viewModel.song.trackName ?? "no name")
            Text(viewModel.song.artistName ?? "no name")
            
            // Playback controls
            Slider(value: $sliderValue, in: 0...sliderMaxValue, step: 0.01)
                .onChange(of: sliderValue ){value in
                    let time = CMTime(seconds:  value, preferredTimescale: 1000)
                    viewModel.seek(to: time)
                }
        
            Text("Slider valuep: \(Int(sliderValue))")
            
            Button(action: {
                if viewModel.isPlaying {
                    viewModel.pause()
                } else {
                    viewModel.play()
                }
            }) {
                Image(systemName: viewModel.isPlaying ? "pause.circle" : "play.circle")
            }
        }.onDisappear{
            viewModel.pause()
        }
        .task {
            let duration = await viewModel.getDuration()
            sliderMaxValue = duration.seconds
        }
            
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var vm = PlayerViewModel(song: mockSong)
    static var previews: some View {
        PlayerView(viewModel: vm)
    }
}

var mockSong: Song = Song(artistID: 82794517, collectionID: nil, trackID: 338383913, artistName: "Tyler Dean McDowell", collectionName: nil, trackName: "Spring time", previewURL: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/ea/77/20/ea772086-2012-5e31-f635-9a7c50ca08ec/mzaf_6697929781492091719.plus.aac.p.m4a", artworkUrl30: nil, artworkUrl60: nil, artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/11/7c/3e/117c3e65-6e6e-74e3-282e-b2d364cc10d5/mzi.evfewjhl.jpg/100x100bb.jpg", collectionPrice: nil, trackPrice: nil, releaseDate: nil, country: nil, currency: nil)
