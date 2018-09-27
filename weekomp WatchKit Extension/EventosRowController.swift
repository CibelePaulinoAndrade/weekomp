//
//  EventosRowController.swift
//  weekomp WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit

class EventosRowController: NSObject {
    @IBOutlet var labelNome: WKInterfaceLabel!
    @IBOutlet var labelHorario: WKInterfaceLabel!
    @IBOutlet var labelDia: WKInterfaceLabel!
    @IBOutlet var imagemCategoria: WKInterfaceImage!
    @IBOutlet var backgroundImagem: WKInterfaceGroup!
    
    
    var evento: Evento? {
        didSet {
            guard let evento = evento else {return}
            
            labelNome.setText(evento.nome)
            labelHorario.setText(evento.horario)
            labelDia.setText(evento.dia)
            
            if evento.sessao == "Gameverse"{
                backgroundImagem.setBackgroundColor(#colorLiteral(red: 0.4705882353, green: 0.4784313725, blue: 1, alpha: 1))
            }
            else if evento.sessao == "Code Space"{
                backgroundImagem.setBackgroundColor(#colorLiteral(red: 0, green: 0.9607843137, blue: 0.9176470588, alpha: 1))
            }
            else if evento.sessao == "Hard Space"{
                backgroundImagem.setBackgroundColor(#colorLiteral(red: 0.9803921569, green: 0.06666666667, blue: 0.3098039216, alpha: 1))
            }
            else if evento.sessao == "Hack Space"{
                backgroundImagem.setBackgroundColor(#colorLiteral(red: 1, green: 0.9019607843, blue: 0.1254901961, alpha: 1))
            }
            else{
                backgroundImagem.setBackgroundColor(#colorLiteral(red: 0.01568627451, green: 0.8705882353, blue: 0.4431372549, alpha: 1))
            }
        }
    }
}
