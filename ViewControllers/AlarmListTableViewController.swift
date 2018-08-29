//
//  AlarmListTableViewController.swift
//  Alarm2.0
//
//  Created by Levi Linchenko on 28/08/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func  swtichIsToggled(sender: SwitchTableViewCell)
}

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler{

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell
        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        cell?.delegate = self
        cell?.alarm = alarm
        
        
        


        return cell ?? UITableViewCell()
    }
    
    func swtichIsToggled(sender: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnabled(for: alarm)
        if alarm.enabled{
            scheduleUserNotification(for: alarm)
        } else {
            cancelUserNotification(for: alarm)
        }
        
        
    }
 

    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.remove(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 

    

   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as? DetailAlarmTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let alarm = AlarmController.shared.alarms[indexPath.row]
            destinationVC?.alarm = alarm
        }
    }
 

}
