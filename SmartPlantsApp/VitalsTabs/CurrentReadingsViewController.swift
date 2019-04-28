//
//  CurrentReadingsViewController.swift
//  SmartPlantsApp
//
//  Created by Anish Palvai on 4/27/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import UserNotifications

class CurrentReadingsViewController: UIViewController {

    @IBOutlet weak var soilHumidityLbl: UILabel!
    
    @IBOutlet weak var soilTempLbl: UILabel!
    
    @IBOutlet weak var soilMoistureLbl: UILabel!
    
    var currentPlant: String?
    
    var temp: Float = 0.0
    var humidity: Float = 0.0
    var moisture: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (didAllow, err) in
            
        })
        
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("plants").document(userID!).getDocument { (snapshot, err) in

            let data = snapshot?.data()
            self.currentPlant = data!["currentSelected"] as? String
            
            self.setUpUI(plant: (data?["currentSelected"] as? String ?? ""))
        }
        
        
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        setUpUI(plant: currentPlant!)
    }
    
    
    func setUpUI(plant: String) {
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection(userID!).document(plant).getDocument { (snapshot, err) in
            let data = snapshot!.data()
            
            self.soilHumidityLbl.text =  data!["Humidity"] as? String
            self.humidity = (data!["Humidity"] as! NSString).floatValue
            self.soilTempLbl.text =  data!["Temperature"] as? String
            self.temp = (data!["Temperature"] as! NSString).floatValue
            self.soilMoistureLbl.text =  data!["Moisture"] as? String
            self.moisture = (data!["Moisture"] as! NSString).floatValue
            
            let moisture = data!["moistureInt"] as! Double
            if  moisture < 0.15 {
                let content = UNMutableNotificationContent()
                content.title = "Water your plants."
                content.body = "Time to water your plants! Their moisture levels are too low."
                content.badge = 1
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: "water", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
            }
            db.collection("plants").document(plant).getDocument(completion: { (snapshot, error) in
                let data = snapshot!.data()
                let maxHum = (data!["maxHumidity"] as! NSString).floatValue
                let minHum = (data!["minHumidity"] as! NSString).floatValue
                let maxTemp = (data!["maxTemp"] as! NSString).floatValue
                let minTemp = (data!["minTemp"] as! NSString).floatValue
                let minMoist = (data!["minMoisture"] as! NSString).floatValue
                let maxMoist = (data!["maxMoisture"] as! NSString).floatValue

                if self.humidity<maxHum && self.humidity>minHum{
                    self.soilHumidityLbl.textColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                }
              
                if self.temp<maxTemp && self.temp>minTemp{
                    self.soilTempLbl.textColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                }
                if self.moisture<maxMoist && self.moisture>minMoist{
                    self.soilTempLbl.textColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                }


            })
        }
        }
    }
    

