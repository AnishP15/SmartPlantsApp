//
//  PlantsTableViewController.swift
//  SmartPlantsApp
//
//  Created by Anish Palvai on 4/27/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PlantsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var plants : [String] = [""]
    
   override func viewDidLoad() {
        super.viewDidLoad()

        let userID = Auth.auth().currentUser?.uid
        var db = Firestore.firestore()
        db.collection(userID!).addSnapshotListener { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    self.plants.append(document.documentID)
                }
            }
        }
        /*
        db.collection(userID!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.plants.append(document.documentID)
                    self.tableView.reloadData()
                }
            }
        }
        */
        }
    
    @IBAction func reloadTapped(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = plants[indexPath.row]
        return cell
        
    } 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        let userID2 = Auth.auth().currentUser?.uid
        var db2 = Firestore.firestore()
        db2.collection("plants").document(userID2!).setData([
            "currentSelected" : plants[indexPath.row]
            ])
        performSegue(withIdentifier: "toStats", sender: Any?.self)
        
        
    }
   
}
