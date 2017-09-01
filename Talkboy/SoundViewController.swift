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
    
    var audioRecorder = AVAudioRecorder()
    
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
                
                var settings : [String:Any] = [:]
                settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
                settings[AVSampleRateKey] = 44100.0
                settings[AVNumberOfChannelsKey] = 2
                
                
                // Create the Audio Recorder
                
                try? audioRecorder = AVAudioRecorder(url: audioURL, settings: settings)
                audioRecorder.prepareToRecord()
            }
        }
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        audioRecorder.record()
    }
    
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
}
