//
//  DetailsViewController.swift
//  weekomp
//
//  Created by Ada 2018 on 02/10/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import WatchConnectivity

class DetailsViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var titleTalk: UILabel!
    @IBOutlet var tag: UILabel!
    @IBOutlet var nameSpeaker: UILabel!
    @IBOutlet var local: UILabel!
    @IBOutlet var hour: UILabel!
    @IBOutlet var details: UITextView!
    @IBOutlet var buttonFavorite: UIButton!
    
    var isFavoriteButton = true
    var talk: Evento?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
        // checking if this talk is a favorite
        guard let nomeTalk = talk?.nome else {return}
        if ManagerFavorite.isFavorite(name: nomeTalk){
            buttonFavorite.setTitle("Desfavoritar", for: .normal)
        }
        isFavoriteButton = ManagerFavorite.isFavorite(name: nomeTalk)
    }
    
    
    
    func setLayout(){
        guard let colorTag = talk?.getColor() else {return}
        titleTalk.text = talk?.nome
        tag.text = talk?.sessao
        tag.textColor = colorTag
        local.text = talk?.local
        hour.text = talk?.horario
        nameSpeaker.text = talk?.palestrante
        buttonFavorite.backgroundColor = colorTag
        buttonFavorite.layer.cornerRadius = 10
        buttonFavorite.clipsToBounds = true
        
    }
    
    
    func sendMessage(message: String, isSaving: Bool){
        if WCSession.default.isReachable {
            var dict: [String: Any] = ["isSaving": isSaving]
            dict["nameTalk"] = message
            WCSession.default.sendMessage(dict, replyHandler: nil, errorHandler: nil)
        }
    }
    
    @IBAction func favorite(_ sender: Any) {
        guard let nomeTalk = talk?.nome else {return}
        if !isFavoriteButton {
            buttonFavorite.setTitle("Desfavoritar", for: .normal)
            //saving in userDefaults
            ManagerFavorite.saving(favoriteName: nomeTalk)
            //sending message to watch
            sendMessage(message: nomeTalk, isSaving: true)
            isFavoriteButton = true
        }else{
            buttonFavorite.setTitle("Favoritar", for: .normal)
            //removing from userDefaults
            ManagerFavorite.removing(favoriteName: nomeTalk)
            //sending message to watch
            sendMessage(message: nomeTalk, isSaving: false)
            isFavoriteButton = false
        }
    }
      

}

extension DetailsViewController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}

