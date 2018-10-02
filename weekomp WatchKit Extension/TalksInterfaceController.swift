//
//  TalksInterfaceController.swift
//  weekomp WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit
import Foundation


class TalksInterfaceController: WKInterfaceController {
    
    @IBOutlet var tableEventos: WKInterfaceTable!
    var eventos: [Evento]?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let idFavoritos = UserDefaults.standard.array(forKey: "Favorites") as? [String] {
            let favoritos = Evento.getFavoritos(idFavoritos)
            self.eventos = favoritos
            
            tableEventos.setNumberOfRows(favoritos.count, withRowType: "EventoRow")
            for i in 0..<favoritos.count {
                guard let controller = tableEventos.rowController(at: i) as? EventosRowController else {continue}
                controller.evento = favoritos[i]
            }
        }
        
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let evento = eventos![rowIndex]
        presentController(withName: "Details", context: (evento, self))
    }
    
}

extension TalksInterfaceController: DefavoriteDelegate {
    func reloadTable(_ evento: Evento) {
        for (index, item) in self.eventos!.enumerated() {
            if (item === evento){
                self.tableEventos.removeRows(at: IndexSet(index..<index+1))
            }
        }
    }
    
}
