// CoreData ile veri kaydetme

import UIKit
import CoreData

class TodoeyViewController: UITableViewController {
    //MARK: - Variables
    
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        view.endEditing(true)
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    /// AddNewItem
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        // create alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // create add buton in alert
        let addAction = UIAlertAction(title: "Add Item", style: .default) { action in
            if let text = textField.text{
                
                let newItem = Item(context: self.context)
                newItem.title = text
                newItem.done = false
                self.itemArray.append(newItem)
                self.saveItems()
            }
            
        }
        // add buton text color changed to systemGreen
        addAction.setValue(UIColor.systemGreen, forKey: "titleTextColor")
        
        // create cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
        
        // add buton text color changed to red
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        // create textField in alert view
        alert.addTextField { alertTextField in
            textField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        // show alert
        present(alert, animated: true, completion: nil)
        
    }
    func saveItems(){
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){

            do{
                itemArray =  try context.fetch(request)
            }catch{
                print("eror fetching data::::",error.localizedDescription)
            }
        
        
        self.tableView.reloadData()
    }
    
  
    

}

extension TodoeyViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@",searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        if searchBar.text == ""{
            loadItems()
        }else{
            loadItems(with: request)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadItems()
        searchBar.text = ""
        view.endEditing(true)
    }
}
