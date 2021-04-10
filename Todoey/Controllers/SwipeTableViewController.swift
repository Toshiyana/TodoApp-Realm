//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Toshiyana on 2021/03/23.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import SwipeCellKit


//swipeTableViewCellに関するmethodをCategoryViewControllerとTodoListViewControllerで利用できるようにするために，作成したviewController
class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate{

    //@IBOutlet weak var editButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80.0//swipeした時にゴミ箱画像がきれいに見えるように高さを変更
        tableView.separatorStyle = .none


    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! SwipeTableViewCell

        cell.delegate = self

        return cell
    }

    //MARK: - SwipeCell Delegate Mehods
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {

        guard orientation == .right else { return nil }//swipeの始まりが右の場合

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.updateModel(at: indexPath)//継承先でoverrideしたものが呼び出される
        }

        // customize the action appearance
        //deleteAction.image = UIImage(named: "Delete-Icon")//画像のファイル名

        return [deleteAction]
    }

    //swipe時の動作に関するmethod
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive//swipeし切るとcellを除去
        return options
    }

    //MARK: - Delete Data from Swipe
    func updateModel(at indexPath: IndexPath) {
        //Update data model.
    }

}
