//
//  ListController.swift
//  Simple Todo
//
//  Created by Manuel Le Bon on 02/06/18.
//  Copyright © 2018 Emanuele Villani. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.leftBarButtonItem = self.editButtonItem // pulsante edit a sinistra
        DataManager.shared.lc = self
	}
    @IBAction func add(_ sender: UIBarButtonItem) {
        let fieldAlert = UIAlertController(title: "Aggiungi", message: "Prodotto o commissione", preferredStyle: .alert)
        
        fieldAlert.addTextField { textField in
            textField.placeholder = "Scrivi qualcosa"
            textField.isSecureTextEntry = false
        }
        
        fieldAlert.addAction( UIAlertAction(title: "Annulla", style: .cancel, handler: nil) )
        
        fieldAlert.addAction( UIAlertAction(title: "Inserisci", style: .default, handler: { (action) in
            // aggiungi qui il codice che deve essere eseguito quando viene premuto il pulsante
            
            if let arreyFields = fieldAlert.textFields,
             let campo = arreyFields.first,
            let testo = campo.text,
                testo.isEmpty == false{
                DataManager.shared.nuovaTodo(name: testo)
            }
        }) )
        
        present(fieldAlert, animated: true, completion: nil)
    }
    
    
	
	// MARK: - Table view data source
	
	// Quante sezioni?
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	// Quante celle?
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DataManager.shared.storage.count // contiamo gli elementi nell'array
	}
	
	// Cosa metto nella cella numero ...?
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.accessoryType = .none
		
		let todo = DataManager.shared.storage [indexPath.row] //estrazione in base al numero della cella
		cell.textLabel?.text = todo.name
        
        if todo.done == true {
             cell.accessoryType = .checkmark
        }
		
		return cell
	}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = DataManager.shared.storage[indexPath.row]
        if todo.done == false {
            todo.done = true
            tableView.cellForRow(at:indexPath)?.accessoryType = .checkmark
            
        } else {
            todo.done = false
            tableView.cellForRow(at:indexPath)?.accessoryType = .none
        }
        DataManager.shared.salva()
        tableView.deselectRow(at: indexPath, animated: true)
    }
	
	// Autorizza la modifica delle celle
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true // si
	}
	
	// Scatta quando l'utente tocca il tasto cancel che appare facendo swipe sulla cella da Dx a Sx
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		
		if editingStyle == .delete {
			
			DataManager.shared.storage.remove(at: indexPath.row)
            DataManager.shared.salva()
            // togliamo l'elemento dall'array
			
			tableView.deleteRows(at: [indexPath], with: .fade) // questo elimina la cella
		}
	}
	
	// Autorizza il riordino delle celle
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		return true // si
	}
	
	// Scatta quando l'utente riordina le celle
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		DataManager.shared.storage.swapAt(fromIndexPath.row, to.row)
        DataManager.shared.salva()
        // scambiamo gli elementi nell'array
	}
}
