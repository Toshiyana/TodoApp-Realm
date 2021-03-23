//
//  Item.swift
//  Todoey
//
//  Created by Toshiyana on 2021/03/22.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")//inverse relationを定義
}
