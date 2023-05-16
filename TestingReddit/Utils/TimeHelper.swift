//
//  TimeHelper.swift
//  TestingReddit
//
//  Created by Wilder López on 5/16/23.
//

import Foundation

class TimeHelper {
    
    static func timeAgoSinceDate(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .weekOfYear, .month, .year], from: date, to: now)
        
        if let years = components.year, years >= 2 {
            return "\(years) years ago"
        } else if let years = components.year, years >= 1 {
            return "Last year"
        } else if let months = components.month, months >= 2 {
            return "\(months) months ago"
        } else if let months = components.month, months >= 1 {
            return "Last month"
        } else if let weeks = components.weekOfYear, weeks >= 2 {
            return "\(weeks) weeks ago"
        } else if let weeks = components.weekOfYear, weeks >= 1 {
            return "Last week"
        } else if let days = components.day, days >= 2 {
            return "\(days) days ago"
        } else if let days = components.day, days >= 1 {
            return "Yesterday"
        } else if let hours = components.hour, hours >= 2 {
            return "\(hours) hours ago"
        } else if let hours = components.hour, hours >= 1 {
            return "An hour ago"
        } else if let minutes = components.minute, minutes >= 2 {
            return "\(minutes) minutes ago"
        } else if let minutes = components.minute, minutes >= 1 {
            return "A minute ago"
        } else if let seconds = components.second, seconds >= 3 {
            return "\(seconds) seconds ago"
        } else {
            return "Just now"
        }
    }
    
}
