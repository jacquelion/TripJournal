//
//  SetTripDatesViewController.swift
//  TripJournal
//
//  Created by Jacqueline Sloves on 4/19/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SetTripDatesViewController : UIViewController {
    
    //MARK - UIOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!

    @IBOutlet weak var nextButton: UIButton!
    
    //MARK - View LifeCycle
    override func viewDidLoad() {
        nextButton.enabled = false
    }
    
    @IBAction func addTitle(sender: AnyObject) {
        enableButton()
    }
    
    @IBAction func addStartDate(sender: UITextField) {
        resignFirstResponder()
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.startDatePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        enableButton()

    }
    
    @IBAction func addEndDate(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.endDatePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)

    }
    
    func startDatePickerValueChanged(sender: UIDatePicker, textFieldToChange: UITextField) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        startDateTextField.text = dateFormatter.stringFromDate(sender.date)
        enableButton()

    }
    
    func endDatePickerValueChanged(sender: UIDatePicker, textFieldToChange: UITextField) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        endDateTextField.text = dateFormatter.stringFromDate(sender.date)
        enableButton()

    }
    
    func validateDates(){
    //TODO: Ensure End date is after Start Date
    }
    
    func enableButton(){
        if titleTextField.text != "" && startDateTextField.text != "" && endDateTextField.text != "" {
            nextButton.enabled = true
        }
    }
  
    @IBAction func nextButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("LoginSegue", sender: self)
    }
    
    }
