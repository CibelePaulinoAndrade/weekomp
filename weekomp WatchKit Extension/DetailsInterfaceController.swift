//
//  DetailsInterfaceController.swift
//  weekomp WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class DetailsInterfaceController: WKInterfaceController {
    @IBOutlet var categoriaLabel: WKInterfaceLabel!
    @IBOutlet var titulo: WKInterfaceLabel!
    @IBOutlet var palestrante: WKInterfaceLabel!
    @IBOutlet var local: WKInterfaceLabel!
    @IBOutlet var eventoDescriptionGroup: WKInterfaceGroup!
    @IBOutlet var favoriteButtonGroup: WKInterfaceGroup!
    @IBOutlet var favoriteButton: WKInterfaceButton!
    @IBOutlet var favoriteLabel: WKInterfaceLabel!
    
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
        favoriteLabel.setText("Desfavoritar")
    }
    
    override func willActivate() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
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
        
        if isFavorite {
            self.favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "star-3"))
            addMenuItem(with: #imageLiteral(resourceName: "star-5"), title: "Favoritar", action: #selector(menuItemAction))
            favoriteLabel.setText("Favoritar")
            guard let nameTalk = evento?.nome else {return}
            ManagerFavorite.removing(favoriteName: nameTalk)
            sendMessage(message: nameTalk, isSaving: false)
            isFavorite = false
        }else{
            self.favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "star-3"))
            addMenuItem(with: #imageLiteral(resourceName: "star-5"), title: "Desfavoritar", action: #selector(menuItemAction))
            favoriteLabel.setText("Desfavoritar")
            guard let nameTalk = evento?.nome else {return}
            ManagerFavorite.saving(favoriteName: nameTalk)
            sendMessage(message: nameTalk, isSaving: true)
            isFavorite = true
            
        }
        
        
//        isFavorite = !isFavorite
//        clearAllMenuItems()
//        if isFavorite {
//            self.favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "star-3"))
//            addMenuItem(with: #imageLiteral(resourceName: "star-5"), title: "Desfavoritar", action: #selector(menuItemAction))
//            favoriteLabel.setText("Desfavoritar")
//        } else {
//            self.favoriteButton.setBackgroundImage(#imageLiteral(resourceName: "star-5"))
//            addMenuItem(with: #imageLiteral(resourceName: "star-3"), title: "Favoritar", action: #selector(menuItemAction))
//            favoriteLabel.setText("Favoritar")
//
//        }
//
//        //self.favoriteUserDefaults()
    }
    
    
}

func sendMessage(message: String, isSaving: Bool){
    if WCSession.default.isReachable {
        var dict: [String: Any] = ["isSaving": isSaving]
        dict["nameTalk"] = message
        WCSession.default.sendMessage(dict, replyHandler: nil, errorHandler: nil)
    }
}

extension DetailsInterfaceController: WCSessionDelegate{
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
    }
    
    
}


