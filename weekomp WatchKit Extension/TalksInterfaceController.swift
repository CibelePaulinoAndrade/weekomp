//
//  TalksInterfaceController.swift
//  weekomp WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class TalksInterfaceController: WKInterfaceController {
    
    @IBOutlet var tableEventos: WKInterfaceTable!
    var eventosFavoritos: [Evento] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        updateTable()
    }
    
    func updateTable(){
        print("update")
        guard let favoritos = UserDefaults.standard.array(forKey: "Favorites") as? [String] else {return}
        eventosFavoritos = Evento.getFavoritos(favoritos)
        print(eventosFavoritos)
        tableEventos.setNumberOfRows(favoritos.count, withRowType: "EventoRow")
        for (index, evento) in eventosFavoritos.enumerated(){
            guard let controller = tableEventos.rowController(at: index) as? EventosRowController else {continue}
            controller.evento = evento
        }

    }
    
    override func willActivate() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let evento = eventosFavoritos[rowIndex]
        presentController(withName: "Details", context: (evento, self))
    }
    
}

extension TalksInterfaceController: DefavoriteDelegate {
    
    func reloadTable(_ evento: Evento) {
        for (index, item) in self.eventosFavoritos.enumerated() {
            if (item === evento){
                self.tableEventos.removeRows(at: IndexSet(index..<index+1))
            }
        }
    }
    
}

extension TalksInterfaceController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard let isSaving = message["isSaving"] as? Bool else {return}
        guard let talkName = message["nameTalk"] as? String else {return}
            DispatchQueue.main.async {
                if isSaving {
                    print("saving")
                    ManagerFavorite.saving(favoriteName: talkName)
                    self.updateTable()
                }else{
                    print("removing")
                    ManagerFavorite.removing(favoriteName: talkName)
                    self.updateTable()
                }
            }
    }
}

