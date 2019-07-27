//
//  Category.swift
//  Todoey
//
//  Created by vishal chaubey on 7/25/19.
//  Copyright © 2019 DeviSons. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    
    //now we set realationship bw Item and category it diffrent from coredate we set that
    // so we set fordword and backward realtionship
    // category have items that type called fordward realtionship
    
    let items = List<Item>()
    
}
