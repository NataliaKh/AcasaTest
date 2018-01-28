//
//  SpendingViewController.swift
//  AcasaTest
//
//  Created by Natuka on 27/01/2018.
//  Copyright © 2018 Natalia. All rights reserved.
//

import UIKit

class SpendingViewController: UIViewController {

    var billStore: BillStore!
    @IBOutlet weak var tableView: UITableView!
    
    private var sections = [Date]()
    private var dateFormatter: DateFormatter!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDateFormatter()
        
        billStore = BillStore()
        billStore.fetchBills { (bills) in
            let dueDateStrings = bills.map{$0.dueDate}
            self.setupSections(datesStrings: dueDateStrings)
            self.tableView.reloadData()
        }
    }
    
    private func setupDateFormatter() {
        dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "YYYY-MM-dd"     //"EEEE, d MMMM"
    }
    
    private func setupSections(datesStrings: [String]) {
        let uniqueDateStrings = Array(Set(datesStrings))
        var dates = [Date]()
        
        for dateString in uniqueDateStrings {
            if let date = dateFormatter.date(from: dateString) {
                dates.append(date)
            }
        }
        sections = dates.sorted(by: { $0.compare($1) == .orderedAscending })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailView" {
            if let detailVC = segue.destination as? BillDetailViewController,
                let bill = sender as? Bill {
                detailVC.bill = bill
            }
        }
    }
}


extension SpendingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dateString = dateFormatter.string(from: sections[section])
        return billStore.bills.filter{$0.dueDate == dateString}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateString = dateFormatter.string(from: sections[indexPath.section])
        let bill = billStore.bills.filter{$0.dueDate == dateString}[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillCell", for: indexPath) as! BillTableViewCell
        cell.configure(bill: bill)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        dateFormatter.dateFormat = "EEEE, d MMMM"
        let dateString = dateFormatter.string(from: sections[section])
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        let label = UILabel(frame: CGRect(x: 10, y: 6, width: tableView.frame.width, height: 50))
        label.backgroundColor = .clear
        label.textColor = .gray
        label.textAlignment = .left
        label.text = dateString
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dateString = dateFormatter.string(from: sections[indexPath.section])
        let bill = billStore.bills.filter{$0.dueDate == dateString}[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetailView", sender: bill)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
