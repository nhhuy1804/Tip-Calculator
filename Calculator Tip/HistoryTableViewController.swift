//
//  HistoryTableViewController.swift
//  Calculator Tip
//
//  Created by MrDummy on 5/31/17.
//  Copyright © 2017 Nhom5. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {

    var arrayHistory: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            for result in results{
                arrayHistory.append(result as! NSManagedObject)
            }
        } catch {
            print("Lỗi")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayHistory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCellTableView
        let history = arrayHistory[indexPath.row]
        cell.lblDateTime.text = history.value(forKeyPath: "date") as? String
        if let billAmount = history.value(forKeyPath: "soTien") {
            cell.lblSoTien.text = "\(billAmount) VNĐ"
        }
        if let tip = history.value(forKeyPath: "tipAmount") {
            cell.lblTipAmount.text =  "\(tip)%"
        }
        if let thanhTien = history.value(forKeyPath: "thanhTien") {
            cell.lblThanhTien.text = "\(thanhTien) VNĐ"
        }

        return cell
    }
}
