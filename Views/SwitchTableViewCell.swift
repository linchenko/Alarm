//
//  SwitchTableViewCell.swift
//  Alarm2.0
//
//  Created by Levi Linchenko on 28/08/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit


class SwitchTableViewCell: UITableViewCell {
    
    //MARK: -Don't UnderStand
    
    var alarm: Alarm?{
        didSet{
            updateView()
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enabledSwitchOutlet: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    func updateView(){
        
        guard let alarm = alarm else {return}
        
        timeLabel.text = alarm.fireTimeAsString
        titleLabel.text = alarm.title
        enabledSwitchOutlet.isOn = alarm.enabled
        
        
    }
    
    
    
    
    
    
    
    @IBAction func switchToggled(_ sender: Any) {
        delegate?.swtichIsToggled(sender: self)
    }
    
}
