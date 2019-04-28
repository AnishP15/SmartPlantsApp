//
//  TemperatureDisplayViewController.swift
//  SmartPlantsApp
//
//  Created by Anish Palvai on 4/27/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import Charts
import FirebaseFirestore
import FirebaseAuth

class TemperatureDisplayViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var minTemp: UILabel!
    
    @IBOutlet weak var maxTemp: UILabel!
    
    var db: Firestore?
    var currentPlant: String?
    var tempArray : [String] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let userID = Auth.auth().currentUser?.uid
        db = Firestore.firestore()
        db!.collection("plants").document(userID!).getDocument { (snapshot, err) in
            
            let data = snapshot?.data()
            self.currentPlant = data?["currentSelected"] as? String
            
            self.setUpUI(plant: (data?["currentSelected"] as? String ?? ""))
        }
        
    }
    
    func setUpUI(plant: String) {
        db?.collection("plants").document(plant).getDocument(completion: { (snapshot, err) in
            let data = snapshot?.data()
            let max = data!["maxTemp"]
            let min = data!["minTemp"]
            
            self.maxTemp.text = "The maximum optimal value for this plant is \(max!) in Celsius"
            self.minTemp.text = "The minimum optimal value for this plant is \(min!) in Celsius"
            
        })
        
        let userID = Auth.auth().currentUser?.uid

        db?.collection(userID!).document(plant).getDocument(completion: { (snapshot, err) in

            let data = snapshot?.data()

            self.tempArray = data!["TempArray"] as! Array<String>
       
            
            self.setChartValues()
        })
       
        
    }

    func setChartValues(){
       
        
        
        let values = (0..<99).map { (i) -> ChartDataEntry in
            
            return ChartDataEntry(x: Double(i), y: Double(tempArray[i])!)
            
        }
        
        let set1 = LineChartDataSet(values: values, label: "Temperature Display over 100 datapoints")
        let data = LineChartData(dataSet: set1)
        
        self.lineChartView.data = data
    }

}
