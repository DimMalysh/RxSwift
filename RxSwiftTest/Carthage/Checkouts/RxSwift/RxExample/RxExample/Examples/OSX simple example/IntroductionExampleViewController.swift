//
//  IntroductionExampleViewController.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 5/19/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Cocoa
import AppKit

class IntroductionExampleViewController : ViewController {
    @IBOutlet var a: NSTextField!
    @IBOutlet var b: NSTextField!
    @IBOutlet var c: NSTextField!
    @IBOutlet var slider: NSSlider!
    @IBOutlet var sliderValue: NSTextField!
    
    @IBOutlet var disposeButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showAlert("After you close this, prepare for a loud sound ...")

        // c = a + b
        let sum = Observable.combineLatest(a.rx.text, b.rx.text) { (a: String, b: String) -> (Int, Int) in
            return (Int(a) ?? 0, Int(b) ?? 0)
        }
        
        // bind result to UI
        sum
            .map { (a, b) in
                return "\(a + b)"
            }
            .bindTo(c.rx.text)
            .addDisposableTo(disposeBag)
        
        // Also, tell it out loud
        let speech = NSSpeechSynthesizer()
        
        sum
            .map { (a, b) in
                return "\(a) + \(b) = \(a + b)"
            }
            .subscribe(onNext: { result in
                if speech.isSpeaking {
                    speech.stopSpeaking()
                }
                
                speech.startSpeaking(result)
            })
            .addDisposableTo(disposeBag)
        
        
        slider.rx.value
            .subscribe(onNext: { value in
                self.sliderValue.stringValue = "\(Int(value))"
            })
            .addDisposableTo(disposeBag)
        
        sliderValue.rx.text
            .subscribe(onNext: { value in
                let doubleValue = value.toDouble() ?? 0.0
                self.slider.doubleValue = doubleValue
                self.sliderValue.stringValue = "\(Int(doubleValue))"
            })
            .addDisposableTo(disposeBag)
        
        disposeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                print("Unbind everything")
                self?.disposeBag = DisposeBag()
            })
            .addDisposableTo(disposeBag)
    }
}
