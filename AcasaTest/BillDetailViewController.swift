//
//  BillDetailViewController.swift
//  AcasaTest
//
//  Created by Natuka on 27/01/2018.
//  Copyright © 2018 Natalia. All rights reserved.
//

import UIKit
import Charts

class BillDetailViewController: UIViewController {

    var bill: Bill?
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupPieChart()
    }
    
    private func setupPieChart() {
       
        guard let bill = self.bill else {
            return
        }
        
        let segments = ["My portion", "Remainder"]
        let amounts = [bill.userShareAmountInPence, bill.amountInPence - bill.userShareAmountInPence]
        
        var entries = [PieChartDataEntry]()
        for (index, value) in amounts.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = Double(value)
            entry.label = segments[index]
            entries.append( entry)
        }
        
        let set = PieChartDataSet( values: entries, label: "Bill Chart")
        
        var colors: [UIColor] = []
        for _ in 0..<amounts.count {
            colors.append(randomColor())
        }
        set.colors = colors
        let data = PieChartData(dataSet: set)
        pieChartView.data = data
    }
    
    private func randomColor() -> UIColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        return color
    }
}
