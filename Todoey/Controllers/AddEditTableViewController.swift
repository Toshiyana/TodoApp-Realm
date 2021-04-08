//
//  AddEditTableViewController.swift
//  Todoey
//
//  Created by Toshiyana on 2021/04/01.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class AddEditTableViewController: SwipeTableViewController {
      
    @IBOutlet weak var editButton: UIBarButtonItem!
    var addButton: FloatingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButton = FloatingButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        //let addButton = FloatingButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        guard let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        else { return }
        keyWindow.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        keyWindow.trailingAnchor.constraint(equalTo: addButton.trailingAnchor,
                                            constant: FloatingButton.trailingValue).isActive = true
        keyWindow.bottomAnchor.constraint(equalTo: addButton.bottomAnchor,
                                          constant: FloatingButton.leadingValue).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: FloatingButton.buttonWidth).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: FloatingButton.buttonHeight).isActive = true
    }
    
    //MARK: - Edit Button Methods
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // update index of moved cell
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //delete cell in Editing mode
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        
        if tableView.isEditing {
            tableView.isEditing = false
            editButton.title = "Edit"
            addButton.isHidden = false
            
        } else {
            tableView.isEditing = true
            editButton.title = "Done"
            addButton.isHidden = true
            
        }
        
    }
    
    //MARK: - Add Button Methods
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        //override in CategoryViewController and TodoListViewController
    }
    
}
