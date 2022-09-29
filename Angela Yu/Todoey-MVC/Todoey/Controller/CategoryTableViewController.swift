//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Kadir Yasin Özmen on 29.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    //MARK: - Varaibles
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    //MARK: - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    
    
    //MARK: - Data Manipulation Methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            if let text = textField.text{
                if textField.text != "" {
                    let newCategory = Category(context: self.context)
                    newCategory.name = text
                    self.categoryArray.append(newCategory)
                    self.saveCategory()
                }
            }
        }
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
    func saveCategory(){
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()){
            do{
                categoryArray =  try context.fetch(request)
            }catch{
                print("eror fetching data::::",error.localizedDescription)
            }
        self.tableView.reloadData()
    }
    
    
    
}
