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
    var eventos = Evento.allEventos()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        tableEventos.setNumberOfRows(eventos.count, withRowType: "EventoRow")
        for i in 0..<tableEventos.numberOfRows {
            guard let controller = tableEventos.rowController(at: i) as? EventosRowController else {continue}
            controller.evento = eventos[i]
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let evento = eventos[rowIndex]
        print(evento.nome)
        //presentController(withName: "Evento", context: evento)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
