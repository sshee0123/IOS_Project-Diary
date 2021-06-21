//
//  ScheduleViewController.swift
//  iosproject-1891196
//
//  Created by 박세희 on 2021/05/25.
//

import Foundation
import UIKit

class ScheduleViewController: UIViewController {
    var starts: String = ""
    var ends: String = ""
    var today : String = "" //오늘 날짜
    var selectday: String = "" //선택 날짜
    var scheduleTitle : String = ""
    var scheduleDetail : String = ""
    var selectIndex : Int = 0

    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
}

//일정 시작시간 datepicker
extension ScheduleViewController{
    @IBAction func startPickerView(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        print("start",formatter.string(from: sender.date))
        starts = formatter.string(from: sender.date)
        print(sender.date)
        
    }
    
//일정 종료시간 datepicker
    @IBAction func endPickerView(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        print("end",formatter.string(from: sender.date))
        ends = formatter.string(from: sender.date)
    }
}

//일정 저장
extension ScheduleViewController{
    
    @IBAction func saveSchedule(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Save Schedule", message: "일정을 저장하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {(_) in
            
        }))
        present(alert,animated: true)
    }
}

extension ScheduleViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //시간 데이터 포맷
        let tmp = scheduleDetail.split(separator: "~")
        starts = String(tmp[0])
        ends = String(tmp[1])
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startdate = formatter.date(from:starts)
        let enddate = formatter.date(from: ends)
        
        //datepicker 초기값 설정
        if let unwrappedStart = startdate{
            startDatePicker.setDate(unwrappedStart, animated: true)
        }
        if let unwrappedEnd = enddate{
            endDatePicker.setDate(unwrappedEnd, animated: true)
        }
        titleTextField.text = scheduleTitle
        scheduleLabel.text = selectday
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
}

extension ScheduleViewController {
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

//뷰가 사라질때 정보 남기고 사라져야함.
extension ScheduleViewController {
    override func viewWillDisappear(_ animated: Bool) {
        
        self.scheduleTitle = titleTextField.text!
        scheduleDetail = starts+"~"
        scheduleDetail+=ends
       
        var currentItem3 = UserDefaults.standard.stringArray(forKey: "titleList") ?? []
        var currentItem4 = UserDefaults.standard.stringArray(forKey: "detailList") ?? []
        currentItem3[self.selectIndex] = self.titleTextField.text!
        currentItem4[self.selectIndex] = self.scheduleDetail
        UserDefaults.standard.setValue(currentItem3, forKey: "titleList")
        UserDefaults.standard.setValue(currentItem4, forKey: "detailList")
        UserDefaults.standard.synchronize()
        
    }
}



