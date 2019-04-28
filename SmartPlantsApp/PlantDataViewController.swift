//
//  ViewController.swift
//  SmartPlantsApp
//
//  Created by Anish Palvai on 4/25/19.
//  Copyright © 2019 Anish Palvai. All rights reserved.
//

import UIKit
import Charts

class PlantDataViewController: UIViewController {

    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChartValues()
    }


    func setChartValues(){
        let values = (0..<20).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(20)) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(values: values, label: "DataSet 1")
        let data = LineChartData(dataSet: set1)
        
        self.lineChartView.data = data
        
    }
}

