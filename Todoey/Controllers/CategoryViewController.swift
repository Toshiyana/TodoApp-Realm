//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Angela Yu on 01/12/2017.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()//try!の意味は後で調べる（!はつけた方が良いときとそうでない時があるみたい）
    
    var categories: Results<Category>?//RealmSwiftはResults型を扱う（listやarrayのようなもの,queryでrealmdatabaseからdataを取得する際はresults型を利用）
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1 //nilだったら1を返す
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //swipeTableViewControllerよりtableView(cellForRowAt)のcellを継承
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
                
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"//これがなぜか表示されない
        
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "0A84FF")//colorがnilの時，nav barの色に設定
        
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)//backgroudcolorによって適宜textcolorを白か黒に設定

        
        return cell
        
    }

    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.categorySegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)//この一行でCategoryの全てのobjectを読み込み可能（coredataのようなrequestの記述が不要）, 戻り値はRealmSwiftのResults型（Container型でlistやarrayのようなもの）
       
        tableView.reloadData()
        
    }
    
    //MARK: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let category = categories?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(category.items)//relationalなdataも除去
                    realm.delete(category)
                }
            } catch {
                print("Error deleting the category, \(error)")
            }
        }
    }
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()//coredataと違ってcontextはいらない
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()//ChameleonFrameworkを利用
            
            //self.categories.append(newCategory)//categoriesはresults型でauto updateされるので，appendする必要ない（realmの変数はmonitor状態にあり）
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}
