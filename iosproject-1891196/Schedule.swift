//
//  Schedule.swift
//  iosproject-1891196
//
//  Created by 박세희 on 2021/05/26.
//

import Foundation

class Schedule: NSObject{
    static var count : Int=0
    var title: String
    var start: String
    var end: String
    
    init(title:String, start:String, end:String){
        self.title = title
        self.start = start
        self.end = end
        super.init()
    }
}

extension Schedule{
    func clone() -> Schedule{
        let schedule = Schedule(title: title, start: start, end: end)
        schedule.title = title
        schedule.start = start
        schedule.end = end
        return schedule
    }
}

extension Schedule{
    func isEqual(schedule: Schedule) -> Bool {
        if schedule.title != title
        { return false }
        else if schedule.start != start
        { return false }
        else if schedule.end != end
        { return false }
        
        return true
    }
}
