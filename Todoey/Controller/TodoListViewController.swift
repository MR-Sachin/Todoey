//
//  ViewController.swift
//  Todoey
//
//  Created by Sachin Verma on 6/26/19.
//  Copyright © 2019 DeviSons. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var defaults = UserDefaults.standard
    var itemArray = [Item]()
//    var itemArray = ["first item","second item","third item","fourth item","fifth item","sixth item","seveth item","eigth item","ninth item","tenth  item","third item","fourth item","fifth item","sixth item","seveth item","eigth item","ninth item","tenth  item"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       let newItem = Item()
        newItem.title = "first item"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "second item"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "third item"
        itemArray.append(newItem3)
        
        // defaults method save app data while some app interption suppose pause and while phone ring and other cases
        //if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
           // itemArray = items
        //}
        
        
        
    }
    
    
    // create a array which hold data which is present in table view now we define at that moment
    
    
    
    // MARK: create table view data sources with no of section which is show in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: create table view cell for each rows of table view , index path is cell of row postion
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: we should not use just uitableViewCell bez when u scroll down upper raw cell create again when u come back it loose all property which u set on this cell... instead of this we use dequeueReuseableCell but one proble occure while we scroll down it use previous cell also reuse with previous cell property which is disappers when u scroll down
       
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCells")
        
        // create a var for reusable cell again and again we dont went to 100 of cell crete one by one
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCells", for: indexPath)
        
        // fill the cell text lable with owers array
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        //shorter way of above code
        //cell.accessoryType = item.done == true ? .checkmark : .none
        
        //more shorter way above previous 2 way
        
        cell.accessoryType = item.done ? .checkmark : .none


        
        return cell
        
    }
    
    
    // MARK : Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

//        this code inshorter way above line
//       if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }

         //same work above code
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
      
    }
    
    // MARK: add new item button
    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
        
        var  textField = UITextField()
        let alert = UIAlertController(title: "Add Todoey New Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //print("logic are work")
            
            let newItem = Item()
            newItem.title = textField.text!

            self.itemArray.append(newItem)

            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    
}



