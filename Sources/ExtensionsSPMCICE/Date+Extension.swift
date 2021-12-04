/*
Copyright, everisSL
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/


import Foundation
import UIKit

public extension Date {
    
    static let dateFormat = "yyyy-MM-dd"
    
    func format(identifier: String = Locale.current.identifier, format: String = dateFormat) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: identifier)
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func byAdding(component: Calendar.Component, value: Int) -> Date {
        
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    var yesterday: Date {
        
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var day: Int {
        
        return Calendar.current.component(.day, from: self)
    }
    
    var tomorrow: Date {
        
        return Calendar.current.date(byAdding: .day, value: +1, to: self)!
    }
    
    var month: Int {
        
        return Calendar.current.component(.month, from: self)
    }
    
    var year: Int {
        
        return Calendar.current.component(.year, from: self)
    }
    
    var lastMonth: Int {
        
        return self.month - 1
    }
    
    var yesterdayMonth: Int {
        
        return Calendar.current.component(.month, from: self.yesterday)
    }
    
    var firstDayMonth: Date {
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: self)
        let startOfMonth = Calendar.current.date(from: comp)!
        return startOfMonth
    }
    
    var lastDayMonth: Date {
        let year = Calendar.current.component(.year, from: self)
        let comp = DateComponents(calendar: Calendar.current, year: year, month: self.month + 1)
        let startDayOfNexMonth = Calendar.current.date(from: comp)!
        let lastDayMonth = startDayOfNexMonth.yesterday
        return lastDayMonth
    }
    
    var firstDayOfYesterdayMonth: Date {
        
        return self.yesterday.firstDayMonth
    }
    
    static func createDate(day: Int,
                                  month: Int,
                                  year: Int) -> Date {
        
        return Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
    }
    
    var mondayOfFirstWeekOfMonth: Date {
        
        let calendar = Calendar.current
        // Convertimos los indices de la semana por defecto Domingo 1, Lunes 2...Sabado 7 a Lunes 1, Martes 2... Domingo 7
        var dayOfWeek = calendar.component(.weekday, from: self.firstDayMonth) + 1 - calendar.firstWeekday
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }
        
        // Le restamos 1 al indice que nos de para luego restar tantos numeros de dias como valor nos resulte este weekIndex a self
        let weekIndex = dayOfWeek - 1
        
        return Calendar.current.date(byAdding: .day, value: -(abs(weekIndex)), to: self.firstDayMonth)!
        
    }
    
    var sundayOfLastWeekOfMonth: Date {
        
        let calendar = Calendar.current
        // Convertimos los indices de la semana por defecto Domingo 1, Lunes 2...Sabado 7 a Lunes 1, Martes 2... Domingo 7
        var dayOfWeek = calendar.component(.weekday, from: self.lastDayMonth) + 1 - calendar.firstWeekday
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }
        
        // Le restamos 1 al indice que nos de para luego sumar tantos numeros de dias como valor nos resulte este weekIndex a self
        
        let weekIndex = 7 - dayOfWeek
        
        return Calendar.current.date(byAdding: .day, value: +(abs(weekIndex)), to: self.lastDayMonth)!
    }
    
    static func getDateOfIndexMonth(monthIndex: Int) -> Date {
        
        let year = Calendar.current.component(.year, from: Date())
        let comp = DateComponents(calendar: Calendar.current, year: year, month: monthIndex)
        return Calendar.current.date(from: comp)!
    }
    
    func weekDay(identifier: String = Locale.current.identifier, removeDiacritics: Bool = true) -> String {
        //let calendar = Calendar.current
        //let comp = calendar.component(.weekday, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: identifier)
        var dayString = dateFormatter.string(from: self)
        if removeDiacritics {
            dayString = dayString.folding(options: .diacriticInsensitive, locale: Locale(identifier: identifier))
        }
        return dayString
    }
    
    func shortWeekDay(identifier: String = Locale.current.identifier, removeDiacritics: Bool = true) -> String {
        //let calendar = Calendar.current
        //let comp = calendar.component(.weekday, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateFormatter.locale = Locale(identifier: identifier)
        var dayString = dateFormatter.string(from: self)
        if removeDiacritics {
            dayString = dayString.folding(options: .diacriticInsensitive, locale: Locale(identifier: identifier))
        }
        return dayString
    }
    
    //-- Get number of weeks from calendar
    var numberOfWeeksInMonth: Int {
        
         var calendar = Calendar(identifier: .gregorian)
        
         calendar.firstWeekday = 2 //sunday=1, monday=2
         let weekRange = calendar.range(of: .weekOfMonth,
                                        in: .month,
                                        for: self)
         return weekRange!.count
    }
    
}
