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
    @IBOutlet var categoriaLabel: WKInterfaceLabel!
    @IBOutlet var titulo: WKInterfaceLabel!
    @IBOutlet var palestrante: WKInterfaceLabel!
    @IBOutlet var local: WKInterfaceLabel!
    @IBOutlet var eventoDescriptionGroup: WKInterfaceGroup!
    @IBOutlet var favoriteButtonGroup: WKInterfaceGroup!
    @IBOutlet var favoriteButton: WKInterfaceButton!
    
    var evento: Evento?
    var isFavorite = true
    var delegate: DefavoriteDelegate?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let contexto = context as! (evento: Evento, delegate: DefavoriteDelegate)
        self.delegate = contexto.delegate
        
        // Configure interface objects here.
        self.setTitle("OK")
        self.evento = contexto.evento
        self.setValores(evento!)
        self.favoriteButtonGroup.setBackgroundColor(evento?.getColor())
        
        self.addMenuItem(with: #imageLiteral(resourceName: "star-5"), title: "Desfavoritar", action: #selector(menuItemAction))
        self.favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "star-3"))
        
    }

    override func willDisappear() {
        super.willDisappear()
        
        if (!self.isFavorite){
            self.delegate?.reloadTable(self.evento!)
        }
    }
    func setCategoriaIndicador (){
        self.categoriaLabel.setTextColor(evento?.getColor())
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
        
        self.favoriteUserDefaults()
    }
    
    private func favoriteUserDefaults() {
        let favorites = UserDefaults.standard.array(forKey: "Favorites") as? [String]
        var fav = favorites
        let eventoNome = (evento?.nome)!
        
        if favorites != nil {
            if !(favorites?.contains(eventoNome))! {
                fav?.append(eventoNome)
            } else {
                let removedIndex = fav?.index(of: eventoNome)
                fav?.remove(at: removedIndex!)
            }
        } else {
            fav = []
            fav?.append(eventoNome)
        }
        
        UserDefaults.standard.set(fav!, forKey: "Favorites")
        
    }
    
}
