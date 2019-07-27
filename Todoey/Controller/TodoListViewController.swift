//
//  ViewController.swift
//  Todoey
//
//  Created by Sachin Verma on 6/26/19.
//  Copyright © 2019 DeviSons. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    // create realm object
    let realm = try! Realm()
 
    //we not using persistiting data saving in plist now we use core data that why not need this line code
   // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //var defaults = UserDefaults.standard
    var todoItems: Results<Item>?
    
    //MARK : MOST IMP Code for saving data into careData see notes for vid 18-17 for more detail
    //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//    var itemArray = ["first item","second item","third item","fourth item","fifth item","sixth item","seveth item","eigth item","ninth item","tenth  item","third item","fourth item","fifth item","sixth item","seveth item","eigth item","ninth item","tenth  item"]
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        // searchBar.delegate = self it outlet set when you call delegate mathod its optonal u do same drag and drop storyboard search bar to main v.c

        //let newItem = Item()
//        newItem.title = "first item"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "second item"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "third item"
//        itemArray.append(newItem3)
        
        // defaults method save app data while some app interption suppose pause and while phone ring and other cases
        //if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
           // itemArray = items
        //}
       
        //loadItems()
        
    }
    
    
    // create a array which hold data which is present in table view now we define at that moment
    
    
    
    // MARK: create table view data sources with no of section which is show in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    // MARK: create table view cell for each rows of table view , index path is cell of row postion
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: we should not use just uitableViewCell bez when u scroll down upper raw cell create again when u come back it loose all property which u set on this cell... instead of this we use dequeueReuseableCell but one proble occure while we scroll down it use previous cell also reuse with previous cell property which is disappers when u scroll down
       
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoItemCells")
        
        // create a var for reusable cell again and again we dont went to 100 of cell crete one by one
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCells", for: indexPath)
        
        // fill the cell text lable with ours Array
        
        if let item = todoItems?[indexPath.row] {
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
            
        }else{
            cell.textLabel?.text = "Item not added yet"
        }
        
        


        
        return cell
        
    }
    
    
    // MARK : Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if let item = todoItems?[indexPath.row]{
            do {
                try! realm.write {
                item.done = !item.done
              }
            }catch{
                print("Error Saving done Status \(error)")
            }
        }
        tableView.reloadData()
        
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        //todoItems?[indexPath.row].done = !todoItems[indexPath.row].done

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
        
        //saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        //tableView.reloadData()
      
    }
    
    // MARK: add new item button
    @IBAction func addNewItemButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Todoey New Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //print("logic are work")
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error Saving new Item\(error)")
                }
            }
        self.tableView.reloadData()
            
        }
            
            //newItem.done = false
            //newItem.parentCategory = self.selectedCategory  // new items in specific selected catrgory(parent category)
            
            
            // self.itemArray.append(newItem)
            
            //saveItems()   not need that bez we save data in manupulation model method

            //self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            
            
            
            //self.tableView.reloadData()   not need tht bez we crate manupulation model method
            
            
            
            
            //self.saveItems()

        
//
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    
    
    //MARK: Model Manupulation Method
    
//    func saveItems() {
//        //let encoder = PropertyListEncoder()
//        do {
//            //let data = try encoder.encode(itemArray)
//            //try data.write(to: dataFilePath!)
//            try context.save()
//        }catch{
//            //print("Encoding item Array, \(error)")
//            print("Error Saving context \(error)")
//        }
//            self.tableView.reloadData()
//    }
//
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()

//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        // now we have to predicate so we create compund predicate for handal both of this
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
////        request.predicate = compoundPredicate
//
//        //optional binding while unwrapping nil value bez we set predicate set default value is nil that is not accepted in subpredicate predicate
//
//        if let addtionaPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionaPredicate])
//        }else {
//            request.predicate = categoryPredicate
//        }
//
//
//
//        do{
//           itemArray = try context.fetch(request)
//        }catch{
//            print("Error fetching data from context \(error)")
//        }
//
   }
    
    
}

// MARK: - Search Bar Method
extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

        tableView.reloadData()
//         let request : NSFetchRequest<Item> = Item.fetchRequest()
//        print(searchBar.text!)
//
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        create a predicate
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request, predicate: predicate) //load items parameter request and predicate
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




