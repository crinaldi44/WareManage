//
//  Item.swift
//  TestProd
//
//  A class that models an Item, displayed upon logging into our
//  application.
//  Created by Chris Rinaldi on 10/18/21.
//

import Foundation
import UIKit

class Item {
    
    //MARK: Properties
    var name: String = "";
    var description: String = "";
    var value: String = "0.0";
    var addDate: String = "";
    var id: Int = 0;
    
    //MARK: Init
    init(withName: String, description: String, value: String, date: String) {
        self.name = withName;
        self.value = value;
        self.addDate = date;
        self.description = description;
    }
    
}
