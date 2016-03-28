//
//  PlaySoundsViewController+Audio.swift
//  PitchPerfect
//
//  Created by GG on 3/25/15.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit
import AVFoundation

extension PlaySoundsViewController: AVAudioPlayerDelegate {
    struct Alerts {
        static let DismissAlert = "Dismiss"
        static let RecordingDisabledTitle = "Recording Disabled"
        static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
        static let RecordingFailedTitle = "Recording Failed"
        static let RecordingFailedMessage = "Something went wrong with your recording"
        static let AudioRecorderError = "Audio Record Error"
        static let AudioSessionError = "Audio Session Error"
        static let AudioFileError = "Audio File Error"
        static let AudioEngineError = "Audio Engine Error"
        
        
    }
    enum PlayingState { case Playing, NOTPlaying}
    
    //MARK: Audio Functions
    
    func setupAudio() {
        do {
            audioFile = try AVAudioFile(forReading: recordedAudioURL)
            
        } catch {
            showAlert(Alerts.AudioFileError, message:String(error))
        }
        print("Audio has been setup")
    }
    
    func playSound(rate rate: Float? = nil, pitch:Float?=nil, echo:Bool = false, reverb:Bool = false) {
        audioEngine = AVAudioEngine()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changeRatePitchNode = AVAudioUnitTimePitch()
        if let pitch = pitch {
            changeRatePitchNode.pitch = pitch
        }
        if let rate = rate {
            changeRatePitchNode.rate = rate
        }
        audioEngine.attachNode(changeRatePitchNode)
        
        let echoNode = AVAudioUnitDistortion()
        echoNode.loadFactoryPreset(.MultiEcho1)
        audioEngine.attachNode(echoNode)
        
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(.Cathedral)
        reverbNode.wetDryMix = 50
        audioEngine.attachNode(reverbNode)
        
        if echo==true && reverb == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, reverbNode, audioEngine.outputNode)
        } else if echo==true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, audioEngine.outputNode)
        } else if reverb == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, reverbNode, audioEngine.outputNode)
        } else {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, audioEngine.outputNode)
        }
        
        audioPlayerNode.stop()
        audioPlayerNode.scheduleFile(audioFile, atTime: nil) {
            var delayInSeconds: Double = 0
            
            if let lastRenderTime = self.audioPlayerNode.lastRenderTime, let playerTime = self.audioPlayerNode.playerTimeForNodeTime(lastRenderTime) {
                
                if let rate = rate {
                    delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate) / Double(rate)
                } else {
                    delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate)
                }
            }
            
            self.stopTimer = NSTimer(timeInterval: delayInSeconds, target:self, selector:"stopAudio", userInfo: nil, repeats: false)
            NSRunLoop.mainRunLoop().addTimer(self.stopTimer, forMode: NSDefaultRunLoopMode)
            
        }
        do{
            try audioEngine.start()
        } catch {
            showAlert(Alerts.AudioEngineError, message: String(error))
            return
        }
        audioPlayerNode.play()
    }
    
    func connectAudioNodes(nodes: AVAudioNode...) {
        for x in 0..<nodes.count-1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
    }
    
    func stopAudio() {
        if let stopTimer = stopTimer {
            stopTimer.invalidate()
        }
        
        configureUI(.NOTPlaying)
        
        if let audioPlayerNode = audioPlayerNode {
            audioPlayerNode.stop()
        }
        if let audioEngine = audioEngine {
            audioEngine.stop()
            audioEngine.reset()
        }

    }
    
    func configureUI(playState: PlayingState) {
        switch(playState) {
        case .Playing:
            setPlayButtonEnabled(false)
            stopButton.enabled = true
        case .NOTPlaying:
            setPlayButtonEnabled(true)
            stopButton.enabled = false
            
        }
    }
    func setPlayButtonEnabled(enabled: Bool) {
        snailButton.enabled = enabled
        rabbitButton.enabled = enabled
        chipmunkButton.enabled = enabled
        reverbButton.enabled = enabled
        vaderButton.enabled = enabled
        echoButton.enabled = enabled

    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title:title, message:message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title:Alerts.DismissAlert, style: .Default, handler: nil))
        self.presentViewController(alert, animated:true, completion:nil)
    }

}
