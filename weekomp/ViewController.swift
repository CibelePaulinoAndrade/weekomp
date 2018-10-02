//
//  ViewController.swift
//  weekomp
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var allEvents: [Evento] = []
    var firtDayEvents: [Evento] = []
    var secondDayEvents: [Evento] = []
    var thirdDayEvents: [Evento] = []
    var fourthEvents: [Evento] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
        })
        
        allEvents = Evento.allEventos()
        firtDayEvents = Evento.eventsOf(day: "16")
        secondDayEvents = Evento.eventsOf(day: "17")
        thirdDayEvents = Evento.eventsOf(day: "18")
        fourthEvents = Evento.eventsOf(day: "19")

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailsViewController {
            guard let talk = sender as? Evento else {return}
            dest.talk = talk
        }
    }
    


}

extension ViewController: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event: Evento?
        switch indexPath.section {
        case 0:
            event = firtDayEvents[indexPath.row]
            
        case 1:
            event = secondDayEvents[indexPath.row]
            
        case 2:
            event = thirdDayEvents[indexPath.row]
            
        case 3:
            event = fourthEvents[indexPath.row]
            
        default:
            return
        }
        performSegue(withIdentifier: "detail", sender: event)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return firtDayEvents.count
            
        case 1:
            return secondDayEvents.count
            
        case 2:
            return thirdDayEvents.count
            
        case 3:
            return fourthEvents.count
            
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = firtDayEvents[indexPath.row].nome
            cell.detailTextLabel?.text = firtDayEvents[indexPath.row].horario
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        case 1:
            cell.textLabel?.text = secondDayEvents[indexPath.row].nome
            cell.detailTextLabel?.text = secondDayEvents[indexPath.row].horario
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        case 2:
            cell.textLabel?.text = thirdDayEvents[indexPath.row].nome
            cell.detailTextLabel?.text = thirdDayEvents[indexPath.row].horario
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        case 3:
            cell.textLabel?.text = fourthEvents[indexPath.row].nome
            cell.detailTextLabel?.text = fourthEvents[indexPath.row].horario
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        default:
            return cell
        }
       
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "16 Out"
        case 1:
            return "17 Out"
        case 2:
            return "18 Out"
        case 3:
            return "19 Out"
        default:
            return ""
        }
    }
    
}
