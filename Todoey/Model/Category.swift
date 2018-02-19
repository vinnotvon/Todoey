//
//  Category.swift
//  Todoey
//
//  Created by Devin Keel on 2/18/18.
//  Copyright © 2018 Devin Keel. All rights reserved.
//

import Foundation
import RealmSwift

//Subclass the "Object" class, which is used to define Realm model objects

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>() //specifies that each category will contain a list of Item objects
}
