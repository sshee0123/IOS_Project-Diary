//
//  TodoListViewController.swift
//  iosproject-1891196
//
//  Created by 박세희 on 2021/05/25.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var todolistLabel: UILabel!
    @IBAction func btnChecked(_ sender: UIButton) {
        checkBtn.isSelected.toggle()
        
    }
}

class TodoListViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var todolistTableView: UITableView!
    @IBOutlet weak var todayLabel: UILabel!
    var selectday: String = "" //선택 날짜
    var todolist = [String]() //todolist
}

extension TodoListViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터 저장
        self.todolist = UserDefaults.standard.stringArray(forKey: "todolist") ?? []
        title = "To Do List" //title 설정
        todayLabel.text = selectday //선택된 날짜 표시
        view.addSubview(todolistTableView)
        self.todolistTableView.dataSource = self
        self.todolistTableView.delegate = self
        
    }
}

//tableview 필수
extension TodoListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = todolistTableView.dequeueReusableCell(withIdentifier: "ToDoCell") as? ToDoCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        cell.textLabel?.text = todolist[index]
        return cell
    }
    
}

//todolist 추가
extension TodoListViewController{
    @IBAction func addTodoList(_ sender: UIBarButtonItem){
        let alert = UIAlertController(title: "오늘 해야할 일", message: "할 수 있는 일만 적으시오.", preferredStyle: .alert)
        alert.addTextField { field in field.placeholder = "Enter todolist"}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {(_) in

            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    
                    var currentItem = UserDefaults.standard.stringArray(forKey: "todolist") ?? []
                    currentItem.append(text)
                    UserDefaults.standard.setValue(currentItem, forKey: "todolist")
                    self.todolist.append(text)
                    self.todolistTableView.reloadData()
                }
            }
        }))
        present(alert,animated: true)
    }
}

//todolist 삭제
extension TodoListViewController{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let alert = UIAlertController(title: "삭제", message: "정말 계획을 삭제하나요?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {
                (action:UIAlertAction) -> Void in
                
                var currentItem1 = UserDefaults.standard.stringArray(forKey: "todolist") ?? []
                currentItem1.remove(at: indexPath.row)
                UserDefaults.standard.setValue(currentItem1, forKey: "todolist")
                
                self.todolist.remove(at: indexPath.row)
                self.todolistTableView.deleteRows(at: [indexPath], with: .automatic)
                self.todolistTableView.reloadData()
                
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}

