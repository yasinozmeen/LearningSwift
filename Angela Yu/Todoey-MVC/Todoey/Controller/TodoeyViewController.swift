//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {
    //MARK: - Variables
    var itemArray: [Items] = []
    let defaults = UserDefaults.standard
    
    
    
    
    //MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.object(forKey: "ToDoListArray") as? [Items]{
            itemArray = items
        }
    }
    
    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        return cell
    }
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)!.accessoryType == .none{
            tableView.cellForRow(at: indexPath)!.accessoryType = .checkmark
        }else{
            tableView.cellForRow(at: indexPath)!.accessoryType = .none
        }
    }
    //MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        // create alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // create add buton in alert
        let addAction = UIAlertAction(title: "Add Item", style: .default) { action in
            if let text = textField.text{
                
                var item = Items()
                item.title = text
                self.itemArray.append(item)
                
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                
                self.tableView.reloadData()
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
}

