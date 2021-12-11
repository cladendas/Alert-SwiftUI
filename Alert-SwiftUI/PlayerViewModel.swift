//
//  PlayerViewModel.swift
//  Alert-SwiftUI
//
//  Created by cladendas on 11.12.2021.
//

import AVFoundation

///Плеер. Есть функциия: старт, стоп, выбор времени песли для начала проигрывания
class PlayerViewModel: ObservableObject {
    ///@Published позволит вьюхе следить за значением этого св-ва
    @Published public var maxDuration: Float = 0.01
    @Published public var currentTime: Float = 0
    
    private var player: AVAudioPlayer?
    
    public func play() {
        playSong(name: "song")
        player?.play()
    }
    
    public func stop() {
        player?.stop()
    }
    
    ///выбор времени в песни для начала проигрывания
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        
        player?.currentTime = time
        currentTime = Float(time)
        player?.play()
    }
    
    private func playSong(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name,
                                               ofType: "mp3") else { return }
                
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = Float(player?.duration ?? 0.0)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
