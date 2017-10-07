//
//  Item.swift
//  AppFightingFantasyIOS
//
//  Created by iossenac on 07/10/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    class func createWith(nomeItem: String, descricaoItem: String?, jogo: Jogo, in context: NSManagedObjectContext) -> Item? {
        let request = NSFetchRequest<Item>(entityName: "Item")
        let query = "nomeItem == %@ and jogo.nome == %@"
        let params: [Any] = [ nomeItem, jogo ]
        
        request.predicate = NSPredicate(format: query, argumentArray: params)
        
        // tenta recuperar o item
        if let item = (try? context.fetch(request))?.first {
            return item
        }
        // senao cria o item
        let item = Item(context:context)
        item.nomeItem = nomeItem
        item.descricaoItem = descricaoItem
        item.jogo = jogo
        return item
    }
}
