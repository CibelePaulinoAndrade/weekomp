//
//  Notifications.swift
//  weekomp WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import Foundation
import UserNotifications


class DateNotification: NSObject {
    
    let dateFormatter = DateFormatter()

    func doNotificationFrom(date dateString: String){
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        let talkDate = dateFormatter.date(from: dateString)
        guard let date = talkDate else{return}
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        doNotification(trigger: trigger)
        
    }
    
    
    func doNotification(trigger: UNCalendarNotificationTrigger){
        let content = UNMutableNotificationContent()
        content.title = "Next talk start in 30 min"
        content.categoryIdentifier = "TALK_START"
        content.sound = UNNotificationSound.default()
        let request = UNNotificationRequest(identifier: "talk", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}


