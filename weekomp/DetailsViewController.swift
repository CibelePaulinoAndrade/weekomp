//
//  DetailsViewController.swift
//  weekomp
//
//  Created by Ada 2018 on 02/10/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var titleTalk: UILabel!
    @IBOutlet var tag: UILabel!
    @IBOutlet var nameSpeaker: UILabel!
    @IBOutlet var local: UILabel!
    @IBOutlet var hour: UILabel!
    @IBOutlet var details: UITextView!
    @IBOutlet var buttonFavorite: UIButton!
    
    var isFavorite = true
    var talk: Evento?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func favorite(_ sender: Any) {
        if isFavorite {
            buttonFavorite.setTitle("Desfavoritar", for: .normal)
            favoriteUserDefaults()
            isFavorite = false
        }else{
            buttonFavorite.setTitle("Favoritar", for: .normal)
            favoriteUserDefaults()
            
        }
       
        
        
    }
    
    private func favoriteUserDefaults() {
        var favorites = UserDefaults.standard.array(forKey: "Favorites") as? [String]
        let eventoNome = (talk?.nome)!
        
        if favorites != nil {
            if !(favorites?.contains(eventoNome))! {
                favorites?.append(eventoNome)
            } else {
                let removedIndex = favorites?.index(of: eventoNome)
                favorites?.remove(at: removedIndex!)
            }
        } else {
            favorites = []
            favorites?.append(eventoNome)
        }
        
        UserDefaults.standard.set(favorites!, forKey: "Favorites")
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
