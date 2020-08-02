//  Date + Ext.swift
//  Created by Dmitry Samartcev on 02.08.2020.

import Foundation

public extension Date {

    /// Get date from string.
    /// - Parameters:
    ///   - dateAsString: String with date.
    ///   - dateFormat: An array of valid formats for decoding.
    /// - Returns: Retrieved date (optional).
    static func dateFromString(_ dateAsString: String?, dateFormat: [String]) -> Date? {
        guard let string = dateAsString else { return nil }
        let dateformatter = DateFormatter()
        dateformatter.timeZone = TimeZone.current
        
        var dateResult : Date?
        dateFormat.forEach { format in
            dateformatter.dateFormat = format
            if let date = dateformatter.date(from: string) {
                dateResult = date
            }
        }
        return dateResult
        
    }
    
    /// Get string from date.
    /// - Parameters:
    ///   - dateIn: Date for decoding.
    ///   - dateFormat: Preferred decoding format.
    /// - Returns: Retrieved date string (optional).
    static func dateToString(_ dateIn: Date?, dateFormat: String) -> String? {
        guard let date = dateIn else { return nil }
        let dateformatter = DateFormatter()
        dateformatter.timeZone = TimeZone.current
        dateformatter.dateFormat = dateFormat
        let val = dateformatter.string(from: date)
        return val
    }
    
    /// Get date string from date string in preferred format.
    /// - Parameters:
    ///   - dateString: Original string containing date.
    ///   - presentFormat: Preferred decoding format.
    ///   - formats: An array of valid formats for source date string.
    /// - Returns: Retrieved date string (optional).
    static func dateStringTo (dateString: String, presentFormat: String, from formats: [String]) -> String? {
        let date = Date.dateFromString(dateString, dateFormat: formats)
        return Date.dateToString(date, dateFormat: presentFormat)
    }
    
    /// Calculates difference between two dates (in years).
    /// - Parameters:
    /// - startDate: Earlier date of two compared.
    /// - endDate: A later date of two compared.
    /// - Returns: Difference between two dates in years.
    static func differenceBetweenDatesInYears(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: startDate, to: endDate)
        return components.year!
    }
}

public enum DateTimeFormats : Int, CaseIterable {
    
    // https://ru.wikipedia.org/wiki/ISO_8601
    // https://nsdateformatter.com
    
    case iso8601
    case simpleDateWithDots
    case dateTimeAndZoneWithDots
    case simpleDateWithDash
    case dateTimeAndZoneWithDash
    
    var description : String {
        switch self {
        case .iso8601:
            return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .simpleDateWithDots:
            return "dd.MM.yyyy"
        case .dateTimeAndZoneWithDots:
            return "dd.MM.yyyy hh:MM:ss Z"
        case .simpleDateWithDash:
            return "dd-MM-yyyy"
        case .dateTimeAndZoneWithDash:
            return "dd-MM-yyyy hh:MM:ss Z"
        }
    }
}
