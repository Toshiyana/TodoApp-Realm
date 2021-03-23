//
//  Category.swift
//  Todoey
//
//  Created by Toshiyana on 2021/03/22.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()//realmで1対多のrelationalなdatabaseを作る際にList<型>を定義
    
    //List<Item>は以下と同じ意味
//    let array = Array<Int>()
//    let array = [Int]()
}
