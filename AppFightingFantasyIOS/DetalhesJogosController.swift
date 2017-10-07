//
//  DetalheJogoController.swift
//  AppFightingFantasyIOS
//
//  Created by iossenac on 07/10/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import CoreData

class DetalhesJogosController: UIViewController {
    
    weak var managedObjectContext: NSManagedObjectContext?
    
    weak var jogo: Jogo? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBOutlet weak var nomeEdit: UITextField!
    @IBOutlet weak var descricaoEdit: UITextField!
    @IBOutlet weak var habEdit: UILabel!
    @IBOutlet weak var eneEdit: UILabel!
    @IBOutlet weak var sorEdit: UILabel!
    
    private func updateUI() {
        nomeEdit?.text = jogo?.nome
        descricaoEdit?.text = jogo?.descricao
        if let hab = jogo?.hab {
            habEdit?.text = String(hab)
        }
        if let ene = jogo?.ene {
            eneEdit?.text = String(ene)
        }
        if let sor = jogo?.sor {
            sorEdit?.text = String(sor)
        }
    }
    
    
    @IBAction func habPlus(_ sender: UIButton) {
        habEdit?.text = String(Int16(habEdit.text!)! + 1)
    }
    
    @IBAction func enePlus(_ sender: UIButton) {
        eneEdit?.text = String(Int16(eneEdit.text!)! + 1)
    }
    
    @IBAction func sorPlus(_ sender: UIButton) {
        sorEdit?.text = String(Int16(sorEdit.text!)! + 1)
    }
    
    @IBAction func habMinus(_ sender: UIButton) {
        habEdit?.text = String(Int16(habEdit.text!)! - 1)
    }
    
    @IBAction func eneMinus(_ sender: UIButton) {
        eneEdit?.text = String(Int16(eneEdit.text!)! - 1)
    }
    
    @IBAction func sorMinus(_ sender: UIButton) {
        sorEdit?.text = String(Int16(sorEdit.text!)! - 1)
    }
    
    // MARK: Handle navigation by saving or not.
    
    /*@IBAction func cancelEdit(_ sender: UIBarButtonItem) {
       _ = navigationController?.popViewController(animated: true)
    }*/
    
    @IBAction func saveJogo(_ sender: UIBarButtonItem) {
        // Se existe um contexto gerenciado...
        if let context = managedObjectContext {
            // ou atualiza o jogo existente...
            if let game = jogo {
                game.nome = nomeEdit.text
                game.descricao = descricaoEdit.text
                
                if let habText = habEdit.text,
                    let hab = Int16(habText)
                {
                    game.hab = hab
                }
                
                if let eneText = eneEdit.text,
                    let ene = Int16(eneText)
                {
                    game.ene = ene
                }
                
                if let sorText = sorEdit.text,
                    let sor = Int16(sorText)
                {
                    game.sor = sor
                }
                
            }
            
            /*else {
                // ou, se o usuario digitou um nome, cria um livro...
                if let titulo = tituloEdit.text
                {
                    let editora = editoraEdit.text
                    var ano: Int16? = nil
                    if let anoText = anoEdit.text {
                        ano = Int16(anoText)
                    }
                    let _ = Livro.createWith(titulo: titulo,
                                             editora: editora,
                                             ano: ano,
                                             in: context)
                }
            }*/
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ListaItensController {
            destination.jogo = jogo
        }
    }
    
}
