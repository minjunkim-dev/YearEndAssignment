import Foundation

extension DateFormatter {
    
    func getGmtToLocalDate(gmt: String) -> String {
        
        let formatter = DateFormatter()
        
        /* GMT String => GMT Date */
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let stringToDate  = formatter.date(from: gmt)

        
        /* GMT Date => Local String */
        // 1. 포맷 변환(유저 지역에 맞게)
        formatter.dateFormat = "yyyy-MM-dd a h:mm"
        formatter.locale = Locale(identifier: Locale.current.identifier)
        
        // 2. 시간 변환(유저 지역에 맞게)
        formatter.timeZone = TimeZone(identifier: Locale.current.identifier)
        
        let localTime = formatter.string(from: stringToDate!)
        
        return localTime
    }
}
