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
    @IBOutlet var local: WKInterfaceLabel!
    @IBOutlet var eventoDescriptionGroup: WKInterfaceGroup!
    @IBOutlet var favoriteButtonGroup: WKInterfaceGroup!
    @IBOutlet var favoriteButton: WKInterfaceButton!
    
    var evento: Evento?
    var isFavorite = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        self.setTitle("OK")
        
        // Configure interface objects here.
        self.evento = context as? Evento
        self.setValores(evento!)
        self.favoriteButtonGroup.setBackgroundColor(evento?.getColor())
        
        addMenuItem(with: #imageLiteral(resourceName: "star-3"), title: "Favoritar", action: #selector(menuItemAction))
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
        self.categoriaIndicador.setBackgroundColor(evento?.getColor())
        self.categoriaIndicador.setCornerRadius(2)
    }
    
    func setValores (_ evento: Evento) {
        self.setCategoriaIndicador()
        self.categoriaLabel.setText(evento.sessao)
        self.titulo.setText(evento.nome)
        self.palestrante.setText(evento.palestrante)
        self.local.setText(evento.local + " às " + evento.horario)
    }
    
    
    @IBAction func favoriteButtonGroupTapped(_ sender: Any) {
        self.handleFavorite()
    }
    
    @IBAction func favoriteButtonAction() {
        self.handleFavorite()
    }
    
    @objc func menuItemAction() {
        self.handleFavorite()
    }
    
    private func handleFavorite() {
        isFavorite = !isFavorite
        clearAllMenuItems()
        if isFavorite {
            self.favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "star-3"))
            addMenuItem(with: #imageLiteral(resourceName: "star-5"), title: "Desfavoritar", action: #selector(menuItemAction))
        } else {
            self.favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "star-5"))
            addMenuItem(with: #imageLiteral(resourceName: "star-3"), title: "Favoritar", action: #selector(menuItemAction))
        }
    }
    
}
