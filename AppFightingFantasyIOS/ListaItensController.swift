//
//  ListaItensController.swift
//  AppFightingFantasyIOS
//
//  Created by iossenac on 07/10/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import CoreData

class ListaItensController: CoreDataTableViewController {
    
    var jogo: Jogo?
    
    var fetchedResultsController: NSFetchedResultsController<Item>? {
        didSet {
            try? refreshData(for: fetchedResultsController)
        }
    }
    
    // MARK: - CoreDataTableViewController FetchedResultsController setup
    
    override func updateRequest()
    {
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.predicate = NSPredicate(format: "jogo.nome == %@", jogo!.nome!)
        request.sortDescriptors = [ NSSortDescriptor(key: "nomeItem", ascending: true) ]
        
        fetchedResultsController = getFetchedResultsController(for: request)
    }
    
    // MARK: - UITableView Cell Render
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath)
        
        if let item = fetchedResultsController?.object(at: indexPath) {
            cellItem.textLabel?.text = item.nomeItem
            cellItem.detailTextLabel?.text = item.descricaoItem
        }
        
        return cellItem
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetalhesItensController {
            destination.jogo = jogo
            destination.managedObjectContext = container?.viewContext
            if segue.identifier == "insertItem" {
                destination.item = nil
            } else
            if let indexPath = tableView.indexPathForSelectedRow,
                let item = fetchedResultsController?.object(at: indexPath)
            {
                destination.item = item
            }
         }
        
    }
    
}
