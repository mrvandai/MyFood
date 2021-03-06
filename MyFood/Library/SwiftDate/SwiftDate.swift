//
//  SwiftDate.swift
//  CM
//
//  Created by DaoNV on 8/25/16.
//  Copyright © 2016 AsianTech Co., Ltd. All rights reserved.
//

import SwiftDate
import SwiftUtils

enum CMDateFormat {
    /// yyyy-MM-dd
    case Date
    /// yyyy/M/d
    case DateShort
    /// yyyy-MM-dd hh:mm:ss
    case DateTime
    /// M/d
    case MonthDay
    /// EEE
    case Weekday
    /// hh:mm:ss
    case Time
    /// hh:mm
    case HourMinute
    /// yyyy.M.d H:mm
    case DateTime2

    var dateFormat: DateFormat {
        switch self {
        case .Date:
            return .custom("yyyy-MM-dd")
        case .DateShort:
            return .custom("yyyy/M/d")
        case .DateTime:
            return .custom("yyyy-MM-dd HH:mm:ss")
        case .MonthDay:
            return .custom("M/d")
        case .Weekday:
            return .custom("EEE")
        case .Time:
            return .custom("HH:mm:ss")
        case .HourMinute:
            return .custom("HH:mm")
        case .DateTime2:
            return .custom("yyyy.M.d H:mm")
        }
    }
}

// MARK: - DateInRegion
extension DateInRegion {
    func toString(format: CMDateFormat) -> String! {
        return toString(format: format.dateFormat)
    }
}

// MARK: - String to Date
extension String {
    func toDate(format: CMDateFormat, region: Region) -> DateInRegion? {
        return DateInRegion(string: self, format: format.dateFormat, fromRegion: region)
    }
}

// MARK: - NSDateFormatter
extension DateFormatter {
    func setRegion(region: Region) {
        calendar = region.calendar
        timeZone = region.timeZone
        locale = region.locale
    }
}

// MARK: - NSDateComponents
extension NSDateComponents {
    convenience init(time: String) {
        var comps = time.componentsSeparatedByString(":")
        if comps.count != 3 {
            Error.fatal("Invalid Time `\(time)`, must be `hh:mm:ss`")
            comps = ["0", "0", "0"]
        }
        self.init()
        hour = comps[0].intValue
        minute = comps[1].intValue
        second = comps[2].intValue
    }
}
