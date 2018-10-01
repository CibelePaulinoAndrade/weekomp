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
    
    func getColor() -> UIColor {
        switch sessao {
        case "Gameverse":
            return UIColor(red: 0.4705882353, green: 0.4784313725, blue: 1, alpha: 1)
        case "Code Space":
            return UIColor(red: 0, green: 0.9607843137, blue: 0.9176470588, alpha: 1)
        case "Hard Space":
            return UIColor(red: 0.9803921569, green: 0.06666666667, blue: 0.3098039216, alpha: 1)
        case "Hack Space":
            return UIColor(red: 1, green: 0.9019607843, blue: 0.1254901961, alpha: 1)
        default:
            return UIColor(red: 0.01568627451, green: 0.8705882353, blue: 0.4431372549, alpha: 1)
            
        }
    }
}
