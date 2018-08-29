//
//  AlarmModel.swift
//  Alarm2.0
//
//  Created by Levi Linchenko on 28/08/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import Foundation

class Alarm: Equatable, Codable{
    
    
    init(title: String, fireTime: Date, enabled: Bool = true, uuid: String = UUID().uuidString){
        self.enabled = enabled
        self.title = title
        self.fireTime = fireTime
        self.uuid = uuid
    }
    
    var title: String
    var fireTime: Date
    var enabled: Bool
    let uuid: String
    
    var fireTimeAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: fireTime)
    }
    
    
    
}

func == (lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}

//import Foundation
//
//class Alarm: Equatable, Codable {
//
//    init(fireDate: Date, name: String, enabled: Bool = true, uuid: String = UUID().uuidString) {
//        self.fireDate = fireDate
//        self.name = name
//        self.enabled = enabled
//        self.uuid = uuid
//    }
//
//    // MARK: Properties
//    var name: String
//    var enabled: Bool
//    let uuid: String
//    var fireDate: Date
//
//    var fireTimeAsString: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .none
//        formatter.timeStyle = .short
//        return formatter.string(from: fireDate)
//    }
//}
//
//// MARK: - Equatable
//
//func ==(lhs: Alarm, rhs: Alarm) -> Bool {
//    return lhs.uuid == rhs.uuid
//}
