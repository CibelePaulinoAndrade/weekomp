//
//  DetailsInterfaceController.swift
//  weekomp WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit
import Foundation


class DetailsInterfaceController: WKInterfaceController {
    @IBOutlet var categoriaIndicador: WKInterfaceGroup!
    @IBOutlet var categoriaLabel: WKInterfaceLabel!
    @IBOutlet var titulo: WKInterfaceLabel!
    @IBOutlet var palestrante: WKInterfaceLabel!
    @IBOutlet var data: WKInterfaceLabel!
    @IBOutlet var local: WKInterfaceLabel!
    @IBOutlet var eventoDescriptionGroup: WKInterfaceGroup!
    
    var evento: Evento?
    var isPresencaConfirmada = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        self.evento = context as? Evento
        self.setValores(evento!)
        
        addMenuItem(with: .accept, title: "Confirmar Presença", action: #selector(menuItemAction))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func setCategoriaIndicador (){
        self.categoriaIndicador.setHeight(18)
        self.categoriaIndicador.setWidth(WKInterfaceDevice.current().screenBounds.size.width)
        self.categoriaIndicador.setBackgroundColor(evento?.getColor())
        self.categoriaIndicador.setCornerRadius(2)
    }
    
    func setValores (_ evento: Evento) {
        self.setCategoriaIndicador()
        self.categoriaLabel.setText(evento.sessao)
        self.titulo.setText(evento.nome)
        self.palestrante.setText(evento.palestrante)
        self.data.setText(evento.dia.replacingOccurrences(of: ".", with: "/") + " às " + evento.horario)
        self.local.setText(evento.local)
    }
    
    @objc func menuItemAction() {
        isPresencaConfirmada = !isPresencaConfirmada
        if isPresencaConfirmada {
            clearAllMenuItems()
            addMenuItem(with: .decline, title: "Cancelar Presença", action: #selector(menuItemAction))
        } else {
            clearAllMenuItems()
            addMenuItem(with: .accept, title: "Confirmar Presença", action: #selector(menuItemAction))
        }
    }
    
}
