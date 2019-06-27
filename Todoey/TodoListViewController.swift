//
//  ViewController.swift
//  Todoey
//
//  Created by Sachin Verma on 6/26/19.
//  Copyright © 2019 DeviSons. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let itemArray = ["first item","second item","third item","fourth item"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // create a array which hold data which is present in table view now we define at that moment
    
    
    
    // MARK: create table view data sources with no of section which is show in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: create table view cell for each rows of table view , index path is cell of row postion
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a var for reusable cell again and again we dont went to 100 of cell crete one by one
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCells", for: indexPath)
        
        // fill the cell text lable with owers array
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    
    // MARK : Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType == .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    


}

