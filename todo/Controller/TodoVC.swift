//
//  TodoVCViewController.swift
//  todo
//
//  Created by Sasha on 28.10.2020.
//

import UIKit

class TodoVC: UIViewController {

    @IBOutlet weak var todoItemTxt: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var todoTable: UITableView!
    
    private var todos = Array<Todo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        NetworkService.instance.getTodos { (todos) in
            self.todos = todos.items
            self.todoTable.reloadData()
        } onError: { (errorMessage) in
            debugPrint(errorMessage)
        }

        
        todoTable.delegate = self
        todoTable.dataSource = self
    }
    
    @IBAction func addTodo(_ sender: Any) {
    }
    
}

extension TodoVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            cell.updateCell(todo: todos[indexPath.row])
            return cell
        }else{
            return TodoCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
