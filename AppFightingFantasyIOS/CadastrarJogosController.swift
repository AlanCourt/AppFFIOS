//
//  CadastrarJogoController.swift
//  AppFightingFantasyIOS
//
//  Created by iossenac on 07/10/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import CoreData

class CadastrarJogosController: UIViewController {
    
    weak var managedObjectContext: NSManagedObjectContext?
    
    var dice1: Int16 = 0
    var dice2: Int16 = 0
    
    weak var jogo: Jogo? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBOutlet weak var nomeCad: UITextField!
    @IBOutlet weak var descricaoCad: UITextField!
    @IBOutlet weak var habCad: UILabel!
    @IBOutlet weak var eneCad: UILabel!
    @IBOutlet weak var sorCad: UILabel!
    
    private func updateUI() {
        nomeCad?.text = jogo?.nome
        descricaoCad?.text = jogo?.descricao
        if let hab = jogo?.hab {
            habCad?.text = String(hab)
        }
        if let ene = jogo?.ene {
            eneCad?.text = String(ene)
        }
        if let sor = jogo?.sor {
            sorCad?.text = String(sor)
        }
    }
    
    private func diceRoll() {
        
        dice1 = Int16((arc4random_uniform(6)) + 1)
        dice2 = Int16((arc4random_uniform(6)) + 1)
        
    }
    
    @IBAction func atriCad(_ sender: UIButton) {
        
        diceRoll()
        habCad?.text = String(dice1 + 6)
        
        diceRoll()
        eneCad?.text = String(dice1 + dice2 + 12)
        
        diceRoll()
        sorCad?.text = String(dice1 + 6)
        
    }
    
    // MARK: Handle navigation by saving or not.
    
    @IBAction func cancelEdit(_ sender: UIBarButtonItem) {
     _ = navigationController?.popViewController(animated: true)
     }
    
    @IBAction func saveJogo(_ sender: UIBarButtonItem) {
        // Se existe um contexto gerenciado...
        if let context = managedObjectContext,
            let nome = nomeCad.text
        {
            let descricao = descricaoCad.text
            
            let _ = Jogo.createWith(nome: nome,
                                    descricao: descricao,
                                    hab: Int16(habCad?.text ?? "erro") ?? -1,
                                    ene: Int16(eneCad?.text ?? "erro") ?? -1,
                                    sor: Int16(sorCad?.text ?? "erro") ?? -1,
                                    in: context)
            
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
