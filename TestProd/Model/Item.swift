//
//  Message.swift
//  TestProd
//
//  A class that models a receivable message, displayed upon logging into our
//  application.
//  Created by Chris Rinaldi on 10/18/21.
//

import Foundation
import UIKit

class Item {
    
    //MARK: Properties
    var name: String = "";
    var value: Float = 0.0;
    var addDate: String = "";
    var id: Int = 0;
    
    //MARK: Init
    init(withName: String, value: Float, date: String) {
        self.name = withName;
        self.value = value;
        self.addDate = date;
    }
    
}
