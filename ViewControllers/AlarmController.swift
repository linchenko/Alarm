//
//  AlarmController.swift
//  Alarm2.0
//
//  Created by Levi Linchenko on 28/08/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController: AlarmScheduler {
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    init(){
        self.alarms = loadFromDisk()
    }
    
    func create(title: String, fireTime: Date, enabled: Bool){
        let alarm = Alarm(title: title, fireTime: fireTime)
        alarm.enabled = enabled
        alarms.append(alarm)
        saveToDisk()
        
        scheduleUserNotification(for: alarm)
    }
    
    func update(alarm: Alarm, title: String, fireTime: Date, enabled: Bool){
        
        cancelUserNotification(for: alarm)
        
        alarm.title = title
        alarm.fireTime = fireTime
        alarm.enabled = enabled
        
        if alarm.enabled{
        scheduleUserNotification(for: alarm)
        }
        saveToDisk()
        
    }
    
    func remove(alarm: Alarm){
        guard let indexPath = alarms.index(of: alarm) else {return}
        alarms.remove(at: indexPath)
        saveToDisk()
        cancelUserNotification(for: alarm)
    }
    
    func toggleEnabled(for alarm: Alarm){
        alarm.enabled = !alarm.enabled
        
    }
    
    
    
    //MARK: -Persistence

    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "alarms.json"
        let documetsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documetsDirectoryURL
    }
    
    func saveToDisk(){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(alarms)
            try data.write(to: fileURL())
        } catch {
            print("Problem saving data \(error)")
        }
        
        
    }
    
    func loadFromDisk() -> [Alarm]{
        do{
            
            let data = try Data(contentsOf: fileURL())
            let decoder = JSONDecoder()
            let alarms = try decoder.decode([Alarm].self, from: data)
            return alarms
        } catch {
            print("Error loading the data \(error)")
        }
        return[]
    }
}


protocol AlarmScheduler: class {
    func scheduleUserNotification(for alarm: Alarm)
    func cancelUserNotification(for alarm: Alarm)
}


extension AlarmScheduler {
    func scheduleUserNotification(for alarm: Alarm){
        
        let content = UNMutableNotificationContent()
        if alarm.title == "Your alarm is going off" {
            
        } else {
            content.title = "Your \(alarm.title) is going off"
        }
        content.body = "That means it's time to get up fatty!"
        
        //MARK: -Don't Understand
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: alarm.fireTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("Problem with request: \(error), \(error.localizedDescription)")
            }
        }
        print("scheduling")
    }
    func cancelUserNotification(for alarm: Alarm){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
        
        print("canceling")
    }
}









