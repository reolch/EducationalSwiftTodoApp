import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    var todoList = [String]()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        
        // 保存されているToDoリストの読み込み
        loadTodoList()
    }
    
    
    /// TODOリストを読み込む関数
    func loadTodoList() {
        if let storedTodoList = userDefaults.array(forKey: "todoList") as? [String] {
            todoList.append(contentsOf: storedTodoList)
        }
    }
    
    /// TODOリストを保存する関数
    func saveTodoList() {
        userDefaults.set(todoList, forKey: "todoList")
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        // TODO: TODOの追加機能を実装する
        let alertController = UIAlertController(title: "ToDo追加", message: "ToDoを入力してください。", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let textField = alertController.textFields?.first, let todoText = textField.text, !todoText.isEmpty {
                self.todoList.insert(todoText, at: 0)
                self.tableview.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
                // 追加したToDoを保存
                saveTodoList()
            }
        }
        
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let todoTitle = todoList[indexPath.row]
        cell.textLabel?.text = todoTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // TODO: TODOの削除機能を実装する
    }
}
