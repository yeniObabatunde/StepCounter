import Foundation

extension String {

    func formatDate() -> String {
           let dateFormatterGet = DateFormatter()
           dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss +ssss"
           let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let dateObj: Date? = dateFormatterGet.date(from: self)?.toLocalTime()
           return dateFormatter.string(from: dateObj!)
        }
}


