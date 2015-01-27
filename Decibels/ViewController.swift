//
//  ViewController.swift
//  Decibels
//
//  Created by AlienLi on 14/12/27.
//  Copyright (c) 2014年 ALN. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    var recorder: AVAudioRecorder?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var url = NSURL.fileURLWithPath("/dev/null")
        
        var settings: [NSString: NSNumber] = [ AVSampleRateKey: 44100,
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.Max.rawValue
        ]
        var error: NSError?
        
        recorder = AVAudioRecorder(URL: url!, settings: settings, error: &error)
        
        if recorder != nil {
            recorder!.prepareToRecord()
            recorder!.meteringEnabled = true
            recorder!.record()
            var levelTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "levelTimerCallback:", userInfo: nil, repeats: true)
        } else {
            println(error!.description)
        }
        
//        var avsession = AVCaptureSession()
//        var captureInputPort = AVCaptureInputPort()
//    
//        var captureConnection: AVCaptureConnection = AVCaptureConnection(inputPort: <#AVCaptureInputPort!#>, videoPreviewLayer: <#AVCaptureVideoPreviewLayer!#>))
    }
    
    func levelTimerCallback(timer:NSTimer) -> Void {
        recorder?.updateMeters()
        
        var level: Float
        
        var minDecibels: Float = -80.0
        var decibels = recorder?.averagePowerForChannel(0)
        
        println("Decibels:\(decibels!)")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

