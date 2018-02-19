//
//  Item.swift
//  Todoey
//
//  Created by Devin Keel on 2/18/18.
//  Copyright © 2018 Devin Keel. All rights reserved.
//

import Foundation
import RealmSwift

//Subclass the "Object" class, which is used to define Realm model objects

class Item: Object {
    @objc dynamic var title : String = "" //a dynamic var can be monitored for change
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") //specify the inverse relationship that each Item object has with its Category
}
