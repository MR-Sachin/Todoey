//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by vishal chaubey on 7/18/19.
//  Copyright © 2019 DeviSons. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    var categories: Results<Category>?
    var realm = try! Realm()
    
    // cumunicater with presistent data for perform CURD operation
    //var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

         loadCategories()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatogoryCells", for: indexPath)
 
        // Configure the cell...
       
        //let category = categories[indexPath.row]
       // cell.textLabel?.text = category.name
       
        // refacture less code just one line
          cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Added yet"
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToItems", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    
    
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
       var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default){ (action) in
            
            //print("logic ar work")
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            
            // call save method while add category
            self.save(category: newCategory)
        }
        
        // this alert object of ui aleartcontriller for add text field with place holder and  alertTextfield value grab into new var text field for save in coreDate for show and maniputation work
        alert.addTextField { (field) in
            textField.placeholder = "Create New Category"
            textField = field
          }
        //  add action button on alert popup and present show the alert pop up
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func save(category: Category ) {
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Category not added \(error)")
        }
        
        tableView.reloadData()
        print("save category list into core data")
    }
    
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
  tableView.reloadData()
    }

}
