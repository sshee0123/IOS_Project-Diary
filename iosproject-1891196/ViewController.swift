//
//  ViewController.swift
//  iosproject-1891196
//
//  Created by 박세희 on 2021/05/18.
//

import UIKit
import FSCalendar

class ScheduleCell: UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
}

class ViewController: UIViewController, UITableViewDelegate {
    var myschedules : [String]=[]
    var selectday: String = "" //선택 날짜
    var today : String = "" //오늘 날짜
    var titleList = [String]()
    var detailList = [String]()
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var scheduleTableView: UITableView!
    
    @IBAction func todolistBtn(_ sender: UIButton) {
    }
    
    @IBAction func diaryBtn(_ sender: UIButton) {
    }
    
}

extension ViewController{
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터 저장
        self.myschedules = UserDefaults.standard.stringArray(forKey: "myschedules") ?? []
        self.titleList = UserDefaults.standard.stringArray(forKey: "titleList") ?? []
        self.detailList = UserDefaults.standard.stringArray(forKey: "detailList") ?? []
        UserDefaults.standard.synchronize()
        
//        //UserDefaults 초기화시 사용
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
    
        calendarView.delegate = self
        calendarView.dataSource = self
    
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        self.navigationItem.title = "My Schedule"
        
        //주말 색 바꾸기
        calendarView.appearance.titleWeekendColor = .red
        //요일 색 바꾸기
        calendarView.appearance.weekdayTextColor = .darkGray
        //선택날짜색, 오늘 날짜 색 바꾸기
        calendarView.appearance.selectionColor = UIColor(red: 195/255, green: 207/255, blue: 255/255, alpha: 1)
        calendarView.appearance.todayColor = UIColor(red: 133/255, green: 152/255, blue: 255/255, alpha: 1)
        //날짜 다중선택 가능
        calendarView.allowsMultipleSelection = true
        //스와이프 동작 다중선택 가능
        calendarView.swipeToChooseGesture.isEnabled = true
        //스와이프 스크롤 작동 여부, 수직으로
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .vertical
        //달력의 년월 글자 바꾸기
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
        calendarView.appearance.headerTitleColor = .black
        calendarView.locale = Locale(identifier: "ko_KR")
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        
    }
}

extension ViewController{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 MM월 dd일 EE"
        selectday = formatter.string(from: date)
        print("\(selectday)")
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd"
        let tmp = formatter2.string(from: date)
        myschedules.append(tmp)
        print("myschedules",myschedules)
    }
}


//일정추가면 점 표시
extension ViewController: FSCalendarDelegate,FSCalendarDataSource{

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd"
        let dateString = formatter2.string(from: date)
        
        if self.myschedules.contains(dateString){
            return 1
        }
        return 0

    }

}


extension ViewController {
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        if let indexPath = scheduleTableView.indexPathForSelectedRow {
            
            let currentItem1 = UserDefaults.standard.stringArray(forKey: "titleList") ?? []
            let currentItem2 = UserDefaults.standard.stringArray(forKey: "detailList") ?? []
            UserDefaults.standard.setValue(currentItem1, forKey: "titleList")
            UserDefaults.standard.setValue(currentItem2, forKey: "detailList")
            
            print("view1",currentItem1)
            print("view2",currentItem2)
            titleList = currentItem1
            detailList = currentItem2
            scheduleTableView.reloadRows(at: [indexPath], with: .automatic)
            scheduleTableView.reloadData()
            UserDefaults.standard.synchronize()
        }
    }
}


//tableview 필수
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as? ScheduleCell else{
            return UITableViewCell()
        }
       
        cell.titleLabel?.text = titleList[indexPath.row]
        //시간 데이터포맷필요
        print("index",indexPath.row)
        cell.detailLabel?.text = detailList[indexPath.row]
        print(titleList.count)
        print(detailList.count)
        cell.detailTextLabel?.textAlignment = .left
        cell.backgroundColor = .white

       
        return cell
    }

}

//일정 edit
extension ViewController{
    @IBAction func editingTable(_ sender: UIBarButtonItem) {
        if scheduleTableView.isEditing == true {
            scheduleTableView.isEditing = false
            sender.title = "Edit"
        } else {
            scheduleTableView.isEditing = true
            sender.title = "Done"
        }
    }
}

//일정 add
extension ViewController{
    @IBAction func addSchedule(_ sender: UIBarButtonItem) {
        var currentItem1 = UserDefaults.standard.stringArray(forKey: "titleList") ?? []
        var currentItem2 = UserDefaults.standard.stringArray(forKey: "detailList") ?? []
        currentItem1.append("Schedule")
        currentItem2.append("12:00~18:00")
        UserDefaults.standard.setValue(currentItem1, forKey: "titleList")
        UserDefaults.standard.setValue(currentItem2, forKey: "detailList")
        self.titleList.append("Schedule")
        self.detailList.append("12:00~18:00")
        self.scheduleTableView.reloadData()
        UserDefaults.standard.synchronize()
    }
}

//일정 선택시 색
extension ViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.backgroundColor = .yellow
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.backgroundColor = .white
    }
}

//일정 delete
extension ViewController {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
         
            let alert = UIAlertController(title: "삭제", message: "정말 계획을 삭제하나요?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {
                (action:UIAlertAction) -> Void in
                
                var currentItem3 = UserDefaults.standard.stringArray(forKey: "titleList") ?? []
                var currentItem4 = UserDefaults.standard.stringArray(forKey: "detailList") ?? []
                currentItem3.remove(at: indexPath.row)
                currentItem4.remove(at: indexPath.row)
                UserDefaults.standard.setValue(currentItem3, forKey: "titleList")
                UserDefaults.standard.setValue(currentItem4, forKey: "detailList")
                
                self.titleList.remove(at: indexPath.row)
                self.detailList.remove(at: indexPath.row)
                self.scheduleTableView.deleteRows(at: [indexPath], with: .automatic)
                self.scheduleTableView.reloadData()
                UserDefaults.standard.synchronize()
                
            }))
            present(alert, animated: true, completion: nil)
            
        }
    }
}

//prepare
extension ViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowSchedule"{
            //스케줄 세그웨이
            let scheduleViewController = segue.destination as! ScheduleViewController
            if let row = scheduleTableView.indexPathForSelectedRow?.row {
                scheduleViewController.selectday = selectday
                scheduleViewController.scheduleTitle = titleList[row]
                scheduleViewController.scheduleDetail = detailList[row]
                scheduleViewController.selectIndex = row
                
                }
            }
        
        if segue.identifier == "ShowTodolist" {
            //투두리스트 세그웨이
            let todolistViewController = segue.destination as! TodoListViewController
            todolistViewController.selectday = selectday
        }
        if segue.identifier == "ShowDiary" {
            //다이어리 세그웨이
            let diaryViewController = segue.destination as! DiaryViewController
            diaryViewController.selectday = selectday
        }
        
    }

}

