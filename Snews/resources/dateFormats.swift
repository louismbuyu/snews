//
//  dateFormats.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 04.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class customDates {
    
    func recentDate(_ date: Date) -> String{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "h:mm a"
        
        let elapsedTimeInSeconds = Date().timeIntervalSince(date)
        
        let secondInDays: TimeInterval = 60 * 60 * 24
        
        if elapsedTimeInSeconds > 7 * secondInDays {
            dateFormatter.dateFormat = "MM/dd/yy"
        } else if elapsedTimeInSeconds > secondInDays {
            dateFormatter.dateFormat = "EEE"
        }
        
        return dateFormatter.string(from: date)
    }
    
    func fulldate(_ date: Date) -> [String] {
        let fullDateFormater = DateFormatter()
        fullDateFormater.dateFormat = "HH:mm - MMMM dd yyyy"
        let fullDate = fullDateFormater.string(from: date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let time = timeFormatter.string(from: date)
        
        return [fullDate, time]
    }
    
    
    func dateToInt(date: Date) -> Int {
        let fullDateFormater = DateFormatter()
        fullDateFormater.dateFormat = "yyyyMMddHHmmSSS"
        let fullDate = fullDateFormater.string(from: date)
        
        return Int(fullDate)!
    }
    
    func dateToNiceString(date: Date) -> String{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "h:mm a"
        
        let elapsedTimeInSeconds = Date().timeIntervalSince(date as Date)
        
        let secondInDays: TimeInterval = 60 * 60 * 24
        
        if elapsedTimeInSeconds > 7 * secondInDays {
            dateFormatter.dateFormat = "MM/dd/yy"
        } else if elapsedTimeInSeconds > secondInDays {
            dateFormatter.dateFormat = "EEE"
        }
        
        return dateFormatter.string(from: date as Date)
    }
    
    func dateWithDayAsString(date: Date) -> String{
        let fullDateFormater = DateFormatter()
        fullDateFormater.dateFormat = "dd EEE MMMM yyyy"
        return fullDateFormater.string(from: date)
    }
    
    func mongodbDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: date as Date)
    }
    
    func mongodbStringToDate(date: String) -> (Date,String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let returnDate = dateFormatter.date(from: date)!
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return (returnDate, timeFormatter.string(from: returnDate))
    }
}
