//
//  Evento.swift
//  weekomp WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import Foundation
import WatchKit

class Evento: Codable {
    
    let nome: String
    let sessao: String
    let palestrante: String
    let horario: String
    let dia: String
    let local: String
    
    class func allEventos() -> [Evento]{
        
        var eventos: [Evento] = []
        guard let path = Bundle.main.path(forResource: "EventoSalas", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return eventos
        }
        do {
            eventos = try JSONDecoder().decode([Evento].self, from: data)
        } catch {
            print(error)
        }
        
        return eventos
        
    }
}
