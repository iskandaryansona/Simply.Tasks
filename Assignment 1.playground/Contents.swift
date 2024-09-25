import PlaygroundSupport

struct SimpleDate{
    var year: Int
    var month: Int
    var day: Int
    var time: MyTime
    
    enum DateFormat {
           case dateOnly
           case shortDate
           case fullDate24Hour
           case fullDate12Hour
           
           var format: String {
               switch self {
               case .dateOnly:
                   return "MM/dd/yyyy"
               case .shortDate:
                   return "MM/yy"
               case .fullDate24Hour:
                   return "MM/dd/yyyy HH:mm"
               case .fullDate12Hour:
                   return "MM/dd/yyyy hh:mm a"
               }
           }
       }
    
    func formatted(format: DateFormat) -> String {
            switch format {
            case .dateOnly:
                return String(format: "%02d/%02d/%04d", month, day, year)
            case .shortDate:
                return String(format: "%02d/%02d", month, year % 100)
            case .fullDate24Hour:
                return String(format: "%02d/%02d/%04d %@", month, day, year, time.check(is24Hour: true))
            case .fullDate12Hour:
                return String(format: "%02d/%02d/%04d %@", month, day, year, time.check(is24Hour: false))
            }
        }
}


struct MyTime{
    var hour: Int
    var minute: Int
    
    func check(is24Hour: Bool) -> String {
         if is24Hour {
             return String(format: "%02d:%02d", hour, minute)
         } else {
             let amPM = hour >= 12 ? "PM" : "AM"
             let hour12 = hour % 12 == 0 ? 12 : hour % 12
             return String(format: "%02d:%02d %@", hour12, minute, amPM)
         }
     }
    
}


let timeOne = MyTime(hour: 15, minute: 30)
let simpleDateOne = SimpleDate(year: 2024, month: 9, day: 25, time: timeOne)

let timeTwo = MyTime(hour: 5, minute: 30)
let simpleDateTwo = SimpleDate(year: 2024, month: 9, day: 25, time: timeTwo)

simpleDateOne.formatted(format: .fullDate12Hour)
