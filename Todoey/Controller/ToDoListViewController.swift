//
//  ViewController.swift
//  Todoey
//
//  Created by Devin Keel on 2/10/18.
//  Copyright © 2018 Devin Keel. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Do Taxes"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Pick Up Bike"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Study for Calc"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] { //this is persisting our data into user defaults
            itemArray = items
        }
        
    }
    
    //MARK: - TableView Datasource Methods
    
    //TODO: Set the numberOfRowsInSection, which is the number of rows in the table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //TODO: 1. Set the text to be displayed for each cell within the table view
    // 2. Check the "done" property to see if the cell needs a checkmark
    // 3. Return the completed cell, including the text and done properties
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
    
        // ==> Use of ternary operator
        // format is....value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        //
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    //TODO: Tell the table view what to do if a cell is touched/selected within the table view
    // 1. When a cell is touched then the checkmark should change state. Set done to opposite
    // 2. Reload rows and sections of the table view
    // 3. Animate the deselection
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //TODO: Add functionality for when the Add button is pressed in the top right corner
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on the UI alert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
    


