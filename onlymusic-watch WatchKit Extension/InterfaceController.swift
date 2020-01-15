
//
//  InterfaceController.swift
//  onlymusic-watch
//
//  Created by Anshul  Mohil on 11/08/19.
//  Copyright © 2019 Anshul  Mohil. All rights reserved.
//
import WatchKit
import Foundation
import AVFoundation
import UIKit

class InterfaceController: WKInterfaceController, WKCrownDelegate {
    
    enum SongState {
        case Playing
        case Paused
    }
    var player: AVAudioPlayer?
    var songState: SongState = .Paused
    var currentVolumeLevel: Float = 1.0
    let numberOfSteps = 3
    
    let ricetta = "Per preparare il polpo in umido cominciate dalla pulizia di quest’ultimo. Dopo averlo ben sciacquato e asciugato, ponetelo su un tagliere e incidete la sacca che contiene gli occhi 1. Poi nella parte al centro, posta sotto il polpo, troverete il dente che andrà tagliato via con un coltellino 2. Per finire pulite l’interno del capo e sciacquate il tutto 3. Procedete pulendo lo scalogno. Dopodiché affettatelo 4 e mettetelo in una ciotola, poi mondate lo spicchio d’aglio e spostatevi ai fornelli. In una pentola capiente scaldate un giro di olio, quindi aggiungete l’aglio 5 e lo scalogno 6. Versate la passata di pomodoro e alzate la fiamma 7, regolate di sale e unite le foglioline di timo 8, la salvia 9,e l’acqua 10. Fate scaldare bene finché il composto non raggiunge il bollore, immergete i tentacoli del polpo per tre volte 11. In questo modo tenderanno ad arricciarsi per bene 12. Assicuratevi che abbiano assunto la tipica forma arricciata e poi immergete completamente 13. Coprite con il coperchio e cuocete a fuoco medio per 50 minuti 14. Per sicurezza ricordatevi di pungere il polpo nella parte interna, dove c’era il dente, se la forchetta non fa troppa fatica a penetrare la polpa, allora si ritiene cotto 15. Quindi spolverizzate il tutto con una macinata di pepe 16 e poi sollevate il polpo spostandolo sul tagliere, tagliatelo a pezzi della grandezza che preferite 17 e servite con il suo sugo. Il vostro polpo in umido è pronto: buon appetito 18."
    
    @IBOutlet var playButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        crownSequencer.focus()
        crownSequencer.delegate = self
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func playButtonTapped() {
        if songState == .Paused {
            songState = .Playing
            playButton.setBackgroundImage(UIImage(named: "Pause"))
            playSound()
        } else if songState == .Playing {
            songState = .Paused
            playButton.setBackgroundImage(UIImage(named: "Play"))
            pauseSound()
        }
    }
    
    @IBAction func sliderAction(_ value: Float) {
        currentVolumeLevel = value
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        let predictedVolumeLevel = currentVolumeLevel + Float(rotationalDelta) * 10
        
        if predictedVolumeLevel > 0.0 && predictedVolumeLevel <= Float(numberOfSteps) {
            currentVolumeLevel = predictedVolumeLevel
            
        }
    }
    
    
    func readMe( myText: String , myLang : String) {
        let utterance = AVSpeechUtterance(string: myText )
        utterance.voice = AVSpeechSynthesisVoice(language: myLang)
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func playSound() {
        
        self.readMe(myText: ricetta , myLang: "en-IT")

        
        
//        guard let url = Bundle.main.url(forResource: "Underworld - Born Slippy (Nuxx) (Creative Commission version)", withExtension: "mp3") else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            player = try AVAudioPlayer(contentsOf: url)
//
//            guard let player = player else { return }
//
//            player.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
    }
    
    func pauseSound() {
        guard let url = Bundle.main.url(forResource: "Underworld - Born Slippy (Nuxx) (Creative Commission version)", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            
            guard let player = player else { return }
            
            player.stop()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
