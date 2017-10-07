//
//  Jogo+CoreDataClass.swift
//  AppFightingFantasyIOS
//
//  Created by iossenac on 07/10/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import Foundation
import CoreData


public class Jogo: NSManagedObject {
    
    class func createWith(nome: String, descricao: String?, hab: Int16, ene: Int16, sor: Int16, in context: NSManagedObjectContext) -> Jogo? {
        let request = NSFetchRequest<Jogo>(entityName: "Jogo")
        let query = "nome == %@"
        let params = [ nome ]
        
        request.predicate = NSPredicate(format: query, argumentArray: params)
        
        // tenta recuperar o jogo
        if let jogo = (try? context.fetch(request))?.first {
            return jogo
        }
        // senao cria o jogo
        let jogo = Jogo(context:context)
        jogo.nome = nome
        jogo.descricao = descricao
        jogo.hab = hab
        jogo.ene = ene
        jogo.sor = sor
        
        return jogo
    }
}
