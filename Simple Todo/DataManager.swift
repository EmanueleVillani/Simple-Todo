//
//  DataManager.swift
//  Simple Todo
//
//  Created by Manuel Le Bon on 02/06/18.
//  Copyright © 2018 Emanuele Villani. All rights reserved.
//

import UIKit

class DataManager {
	
	static let shared = DataManager()
	
	var storage : [TodoModel] = []
    // agg. var della table
    var lc : ListController?
	
	func caricaDati() {
        
        if let data = UserDefaults.standard.data(forKey: "salva") {
            storage =  NSKeyedUnarchiver.unarchiveObject(with: data) as! [TodoModel]
        } else {
            let pizza = TodoModel(name: "Pizza")
             let birra = TodoModel(name: "Birra")
            storage = [birra,pizza]
        }
		
	}
    
    func nuovaTodo (name:String){
        let todo = TodoModel(name:name)
        storage.insert(todo, at: 0)
        salva()
       
        lc?.tableView.reloadData ()
    
    }
	func salva() {
		let data = NSKeyedArchiver.archivedData(withRootObject: storage)
        
        UserDefaults.standard.set(data, forKey: "salva")
        UserDefaults.standard.synchronize()
	}
	
	
}
