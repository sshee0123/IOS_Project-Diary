//
//  DateBySchedule.swift
//  iosproject-1891196
//
//  Created by 박세희 on 2021/05/31.
//

import UIKit

class TodaySchedule: NSObject {
    var todaySchedule = [ScheduleGroup]()
  
    override init() {
        super.init()
    }
    
    func count() -> Int{
        return todaySchedule.count
        
    }
    func addSchedule(scheduleGroup:ScheduleGroup){
        todaySchedule.append(scheduleGroup)
    }
    func modifySchedule(scheduleGroup:ScheduleGroup,index:Int){
        todaySchedule[index] = scheduleGroup
    }
    func removeSchedule(index: Int){
        todaySchedule.remove(at: index)
    }
    func getSchedule(date:String){
        
    }
    
}

extension TodaySchedule{
    func clone() -> TodaySchedule{
        let todaySchedule = TodaySchedule()
        return todaySchedule
    }
}

extension TodaySchedule{
    func isEqual(todaySchedule: TodaySchedule) -> Bool {
        
        return true
    }
}
