import Foundation

extension Date {
    
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date().toLocalTime() ))!
    }
    
    static func restAt12AmDaily() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.weekdayOrdinal, .day], from: Date().toLocalTime()))!
    }
    
    static func resetAtTheEndOfTheMonth() -> Date {
        let calendar = Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.weekOfMonth, .month], from: Date().toLocalTime()))!
        return calendar
    }
    
    static func getCurrentMonth() -> String {
        let date = Date().convert()
        let stringToArray = date.components(separatedBy: " ")
        let monthOfTheYear = stringToArray[0]
        let day = stringToArray[1]
        return "\(monthOfTheYear + " " + day )"
    }
    
    func startOfDay() -> Date {
        let interval = Calendar.current.dateInterval(of: .month, for: self)
        return (interval?.start.toLocalTime())! // Without toLocalTime it give last months last date
        //    2022-04-16 00:00:00 +0000 The start of the day 12am
    }
    
    func endOfMonth() -> Date {
        let interval = Calendar.current.dateInterval(of: .month, for: self)
        return (interval!.end.toLocalTime())
        // 2022-04-30 23:00:00 +0000 The end of the month
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone    = TimeZone.current
        let seconds     = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
        // 2022-04-14 09:38:16 +0000 Local time rigth noe
    }
    
    func convertFromCurrentDateToAmonthBack() -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -1, to: Date().toLocalTime())!
        // 2022-03-15 23:38:14 +0000
        return endDate
    }
    
    func convert() -> String {
        let date = Date().convertFromCurrentDateToAmonthBack()
        let localizedTime = "\(date)".formatDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        dateFormatter.date(from: localizedTime)
        return String(localizedTime)
        // March 16, 2022
    }
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        let newDate = dateFormatter.string(from: Date().toLocalTime())
        let formattedDate = newDate.split(separator: " ")
        let month = formattedDate[0]
        let day = formattedDate[1]
        let year = formattedDate[2]
        let dateNeeded = month + " " + day + year
        print(dateFormatter.string(from: Date())) // Apr 15, 2022
        return String(dateNeeded)
        
    }
}
