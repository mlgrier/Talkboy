//
//  SoundViewController.swift
//  Talkboy
//
//  Created by Marco Grier on 8/30/17.
//  Copyright © 2017 Marco Grier. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet weak var soundNameTextField: UITextField!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Audio Session
        
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? session.overrideOutputAudioPort(.speaker)
        try? session.setActive(true)
        
        // URL to save the audio
        
        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let patchCompoenents = [basePath, "audio.m4a"]
            if let audioURL = NSURL.fileURL(withPathComponents: patchCompoenents) {
                // Create some settings
                
                self.audioURL = audioURL
                var settings : [String:Any] = [:]
                settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
                settings[AVSampleRateKey] = 44100.0
                settings[AVNumberOfChannelsKey] = 2
                
                
                // Create the Audio Recorder
                
                audioRecorder = try? AVAudioRecorder(url: audioURL, settings: settings)
                audioRecorder?.prepareToRecord()
            }
        }
        
        playButton.isEnabled = false
        soundNameTextField.isEnabled = false
        addButton.isEnabled = false
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if let audioRecorder = self.audioRecorder {
            
            if audioRecorder.isRecording {
                audioRecorder.stop()
                recordButton.setTitle("Record", for: .normal)
                playButton.isEnabled = true
                soundNameTextField.isEnabled = true
                addButton.isEnabled = true
            } else {
                audioRecorder.record()
                recordButton.setTitle("Stop", for: .normal)
                playButton.isEnabled = false
                soundNameTextField.isEnabled = false
                addButton.isEnabled = false
            }
        }
        
    }
    
    
    @IBAction func playTapped(_ sender: Any) {
        if let audioURL = self.audioURL {
            audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
            
        }
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
}
