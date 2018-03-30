//
//  ViewController.swift
//  RxCocoaTest
//
//  Created by mac on 30.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    //TapGestureRecognizer
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    //Button and Label
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    
    //Slider and ProgressView
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressView: UIProgressView!
    
    //SegmentedControl and Label
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedControlLabel: UILabel!
    
    //DatePicker and Label
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerLabel: UILabel!
    
    //TextField and Label
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldLabel: UILabel!
    
    //TextView and Label
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewLabel: UILabel!
    
    //Switch and ActivityIndicator
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Stepper and Label
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!

    //DisposeBag - в этом примере он объявлен как свойство. Это нужно, чтобы во время вызова системой deinit, происходило освобождение ресурсов для Observable-объектов.
    
    let disposeBag = DisposeBag()
    
    //DateFormatt for DatePicker
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tapGestureRecognizer.rx.event.asDriver().drive(onNext: { [unowned self] _ in
            self.view.endEditing(true)
        }).addDisposableTo(disposeBag)
        
        textField.rx.text.bindNext {
            self.textFieldLabel.text = $0
            }.addDisposableTo(disposeBag)
        
        textView.rx.text.bindNext {
            self.textViewLabel.text = "Character count: \($0.characters.count)"
            }.addDisposableTo(disposeBag)
        
        button.rx.tap.asDriver().drive(onNext: {
            self.buttonLabel.text! += "Hello, RxSwift"
            self.view.endEditing(true)
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }).addDisposableTo(disposeBag)
        
        slider.rx.value.asDriver().drive(progressView.rx.progress).addDisposableTo(disposeBag)
        
        
        segmentedControl.rx.value.asDriver().skip(1).drive(onNext: {
            self.segmentedControlLabel.text = "Selected segment = \($0)"
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }).addDisposableTo(disposeBag)
        
        datePicker.rx.date.asDriver()
            .map {
                self.dateFormatter.string(from: $0)
            }.drive(onNext: {
                self.datePickerLabel.text = "Selected date: \($0)"
                
            }).addDisposableTo(disposeBag)
        
        stepper.rx.value.asDriver().map { String(Int($0)) }.drive(stepperLabel.rx.text).addDisposableTo(disposeBag)
        
        mySwitch.rx.value.asDriver().map { !$0 }.drive(activityIndicator.rx.hidden).addDisposableTo(disposeBag)
        
        mySwitch.rx.value.asDriver().drive(activityIndicator.rx.animating).addDisposableTo(disposeBag)
    }
}

