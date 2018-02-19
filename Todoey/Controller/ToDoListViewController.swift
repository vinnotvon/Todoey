//
//  ViewController.swift
//  Todoey
//
//  Created by Devin Keel on 2/10/18.
//  Copyright © 2018 Devin Keel. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    var itemArray: Results<Item>? //change to a new collection type...a collection of result

    let realm = try! Realm() //initialize a new access point to our Realm database
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - TableView Datasource Methods
    
    //TODO: Set the numberOfRowsInSection, which is the number of rows in the table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    //TODO: 1. Set the text to be displayed for each cell within the table view
    // 2. Check the "done" property to see if the cell needs a checkmark
    // 3. Return the completed cell, including the text and done properties
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = itemArray?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            // ==> Use of ternary operator
            // format is....value = condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Item Added"
        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    //TODO: Tell the table view what to do if a cell is touched/selected within the table view
    // 1. When a cell is touched then the checkmark should change state. Set done to opposite
    // 2. Reload rows and sections of the table view
    // 3. Animate the deselection
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArray?[indexPath.row]{
            do {
                try realm.write {
                    item.done = !item.done
                    }
                } catch {
                    print("Error saving items, \(error)")
                }
            }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    //TODO: Add functionality for when the Add button is pressed in the top right corner
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on the UI alert
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new item, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func save(item: Item) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Error saving item \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    
   }
    
} // closing of ToDoListViewController


//MARK: - Search Bar Protocol Methods
extension ToDoListViewController: UISearchBarDelegate {
//
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        itemArray = itemArray?.filter( "title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}



