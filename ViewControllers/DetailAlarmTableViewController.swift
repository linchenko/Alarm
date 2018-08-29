//
//  DetailAlarmTableViewController.swift
//  Alarm2.0
//
//  Created by Levi Linchenko on 28/08/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class DetailAlarmTableViewController: UITableViewController {

    var alarmIsOn: Bool = true
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    var alarm: Alarm?{
        didSet{
            loadViewIfNeeded()
            updateView()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()

    }
    
    func updateView(){
        guard let alarm = alarm else {return}
        titleLabel.text = alarm.title
        timePicker.date = alarm.fireTime
        updateSwitch()
    }
    
    
    func updateSwitch(){
        guard let alarm = alarm else {return}
        alarmIsOn = alarm.enabled
        if alarmIsOn{
            enableButton.backgroundColor = .red
            enableButton.setTitle("Disable", for: UIControlState.normal)
        } else {
            enableButton.backgroundColor = .green
            enableButton.setTitle("Enable", for: UIControlState.normal)
        }
    }

    



    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleLabel.text else {return}
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, title: title, fireTime: timePicker.date, enabled: alarmIsOn)
        } else {
            AlarmController.shared.create(title: title, fireTime: timePicker.date, enabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    
  
    @IBAction func enableToggled(_ sender: Any) {
        guard let alarm = alarm else {return}
        AlarmController.shared.toggleEnabled(for: alarm)
        alarmIsOn = alarm.enabled
        updateSwitch()
        
        
    }
    
}
