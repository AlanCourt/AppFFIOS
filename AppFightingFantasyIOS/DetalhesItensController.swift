//
//  DetalhesItensController.swift
//  AppFightingFantasyIOS
//
//  Created by iossenac on 07/10/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import CoreData

class DetalhesItensController: UIViewController {
    
    weak var managedObjectContext: NSManagedObjectContext?
    
    var jogo: Jogo?
    
    weak var item: Item? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBOutlet weak var nomeItemEdit: UITextField!
    @IBOutlet weak var descricaoItemEdit: UITextField!
    
    private func updateUI() {
        nomeItemEdit?.text = item?.nomeItem
        descricaoItemEdit?.text = item?.descricaoItem
    }
    
    // MARK: Handle navigation by saving or not.
    
    @IBAction func cancelEdit(_ sender: UIBarButtonItem) {
     _ = navigationController?.popViewController(animated: true)
     }
    
    @IBAction func saveItem(_ sender: UIBarButtonItem) {
        // Se existe um contexto gerenciado...
        if let context = managedObjectContext {
            // ou atualiza o item existente...
            if let itemM = item {
                itemM.nomeItem = nomeItemEdit.text
                itemM.descricaoItem = descricaoItemEdit.text
            }
            
            else {
             // ou, se o usuario digitou um nome, cria um item...
             if let nomeItem = nomeItemEdit.text
             {
             let descricaoItem = descricaoItemEdit.text
            
             let _ = Item.createWith(nomeItem: nomeItem,
                                     descricaoItem: descricaoItem,
                                     jogo: jogo!,
                                     in: context)
             }
             }
            
            // ao final, salva as alteracoes do documento.
            do {
                try context.save()
            } catch let error {
                print("\(error)")
            }
        }
        // retorna a tela anterior
        _ = navigationController?.popViewController(animated: true)
    }
    
}

