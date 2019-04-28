//
//  SetUpPlantViewController.swift
//  SmartPlantsApp
//
//  Created by Anish Palvai on 4/27/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class SetUpPlantViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    let plants = ["Bamboo", "cotton", "aloe vera", "corn crop", "money plant", "rice crop", "peace lilt"]
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plants[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plants.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection(userID!).document(plants[row]).setData(
            ["humidity":0,
            "temperature":0,
            "moisture": 0])
    }
    
//   func getReadings() -> [String: String] {
    

 //   }
    
    


}
