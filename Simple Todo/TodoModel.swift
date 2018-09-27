//
//  TodoModel.swift
//  Simple Todo
//
//  Created by Manuel Le Bon on 02/06/18.
//  Copyright © 2018 Emanuele Villani. All rights reserved.
//

import UIKit

class TodoModel: NSObject, NSCoding{
    
    var name: String
    var done: Bool = false
    
init(name: String) {
    self.name = name
}
    
 

internal required init?(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: "name") as! String
    self.done = aDecoder.decodeBool(forKey: "done")
}

func encode(with encoder: NSCoder) {
    encoder.encode(self.name, forKey: "name")
    encoder.encode(self.done, forKey: "done")
}

}
