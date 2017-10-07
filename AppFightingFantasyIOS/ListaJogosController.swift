//
//  ViewController.swift
//  AppFightingFantasyIOS
//
//  Created by iossenac on 07/10/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import CoreData

class ListaJogosController: CoreDataTableViewController
{
    var fetchedResultsController: NSFetchedResultsController<Jogo>? {
        didSet {
            try? refreshData(for: fetchedResultsController)
        }
    }
    
    // MARK: - CoreDataTableViewController FetchedResultsController setup
    
    override func updateRequest()
    {
        let request = NSFetchRequest<Jogo>(entityName: "Jogo")
        request.sortDescriptors = [ NSSortDescriptor(key: "nome", ascending: true) ]
        
        fetchedResultsController = getFetchedResultsController(for: request)
    }
    
    // MARK: - UITableView Cell Render
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let jogo = fetchedResultsController?.object(at: indexPath) {
            cell.textLabel?.text = jogo.nome
            cell.detailTextLabel?.text = jogo.descricao
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if let destination = segue.destination as? DetalheLivroController {
            destination.managedObjectContext = container?.viewContext
            if segue.identifier == "insertLivro" {
                destination.livro = nil
            } else
                if let indexPath = tableView.indexPathForSelectedRow,
                    let livro = fetchedResultsController?.object(at: indexPath) {
                    destination.livro = livro
            }
        }*/
        
        if segue.identifier == "editJogo" {
            if let destination = segue.destination as? DetalhesJogosController {
                destination.managedObjectContext = container?.viewContext
                if let indexPath = tableView.indexPathForSelectedRow,
                    let jogo = fetchedResultsController?.object(at: indexPath) {
                    destination.jogo = jogo
                }
            }

        } else {
            
            if let destination = segue.destination as? CadastrarJogosController {
                destination.managedObjectContext = container?.viewContext
                    destination.jogo = nil
            }

        }
        
    }
    
}
