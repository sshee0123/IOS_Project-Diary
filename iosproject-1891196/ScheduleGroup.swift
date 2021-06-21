//
//  ScheduleGroup.swift
//  iosproject-1891196
//
//  Created by 박세희 on 2021/05/26.
//

import Foundation

class ScheduleGroup:NSObject{
    var schedules = [Schedule]()
    var date: String
    
    init(date: String) {
        self.date = date
        super.init()
    }
    func testData(){
        
        schedules.append(Schedule(title: "schedule" ,start: "12:00" ,end: "18:00"))
        
    }
    func count(date:String) -> Int{
            return schedules.count
    }
    func addSchedule(date:String,schedule:Schedule){
        schedules.append(schedule)
        print("addsche",date)
        print(schedule)
    }
    func modifySchedule(date:String,schedule:Schedule,index:Int){
        schedules[index] = schedule
    }
    func removeSchedule(date:String,index: Int){
        schedules.remove(at: index)
    }
    func getSchedule(date:String,schedule:Schedule,index:Int){
        print(schedules[index])
        
    }
    
}


extension ScheduleGroup{
    func clone() -> ScheduleGroup{
        let scheduleGroup = ScheduleGroup(date: date)
        return scheduleGroup
    }
}

extension ScheduleGroup{
    func isEqual(scheduleGroup: ScheduleGroup) -> Bool {
        
        return true
    }
}
