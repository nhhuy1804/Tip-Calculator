//
//  ViewController.swift
//  Calculator Tip
//
//  Created by Cntt35 on 5/27/17.
//  Copyright © 2017 Nhom5. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtSoTien: UITextField!
    @IBOutlet weak var txtTipAmount: UITextField!
    @IBOutlet weak var btnTinh: UIButton!
    @IBOutlet weak var txtTienTip: UITextField!
    @IBOutlet weak var txtThanhTien: UITextField!
    
    var tipAmount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let tip = UserDefaults.standard.object(forKey: "tip") as? Int {
            txtTipAmount.text = String(tip)
            tipAmount = tip
        }else {
            txtTipAmount.text = "5"
            tipAmount = 5
        }
        txtTienTip.text = ""
        txtThanhTien.text = ""
    }

    override func viewDidAppear(_ animated: Bool) {
        if let tip = UserDefaults.standard.object(forKey: "tip") as? Int {
            txtTipAmount.text = "\(tip) %"
            tipAmount = tip
        }
        //txtSoTien.text?.removeAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnTinhAction(_ sender: Any) {       
        let soTien: Double = Double(txtSoTien.text!)!
        let tienTip: Double = soTien * Double(tipAmount!) / 100
        let thanhTien = soTien + tienTip
        let date = getDateTime()
        
        txtTienTip.text = "\(tienTip) VNĐ"
        txtThanhTien.text = "\(thanhTien) VNĐ"
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let history = NSEntityDescription.insertNewObject(forEntityName: "history", into: context) as NSManagedObject
        
        history.setValue(date, forKeyPath: "date")
        history.setValue(soTien, forKeyPath: "soTien")
        history.setValue(tipAmount, forKeyPath: "tipAmount")
        history.setValue(thanhTien, forKeyPath: "thanhTien")
        
        do {
            try context.save()
        } catch {
            fatalError("Lưu thất bại: \(error)")
        }
    }
    
    func getDateTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = NSTimeZone() as TimeZone!
        let localDate = dateFormatter.string(from: date)
        return localDate
        
        
    }

}

