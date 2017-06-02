//
//  ViewController.swift
//  Calculator Tip
//
//  Created by Cntt35 on 5/27/17.
//  Copyright © 2017 Nhom5. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtSoTien: UITextField!
    @IBOutlet weak var txtTipAmount: UITextField!
    @IBOutlet weak var btnTinh: UIButton!
    @IBOutlet weak var txtTienTip: UITextField!
    @IBOutlet weak var txtThanhTien: UITextField!
    
    var tipAmount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.txtSoTien.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        if let tip = UserDefaults.standard.object(forKey: "tip") as? Int {
            txtTipAmount.text = String(tip)
            tipAmount = tip
        }else {
            txtTipAmount.text = "5%"
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
        txtSoTien.text?.removeAll()
        txtTienTip.text?.removeAll()
        txtThanhTien.text?.removeAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnTinhAction(_ sender: Any) {
        
        //txtSoTien != empty
        if txtSoTien.text != "" {
            let soTien: Double = Double(txtSoTien.text!)!
            let tienTip: Double = soTien * Double(tipAmount!) / 100
            let thanhTien = soTien + tienTip
            let date = getDateTime()
            
            txtTienTip.text = "\(tienTip) VNĐ"
            txtThanhTien.text = "\(thanhTien) VNĐ"
            
            // Save core data
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let history = NSEntityDescription.insertNewObject(forEntityName: "History", into: context) as NSManagedObject
            
            history.setValue(date, forKeyPath: "date")
            history.setValue(soTien, forKeyPath: "soTien")
            history.setValue(tipAmount, forKeyPath: "tipAmount")
            history.setValue(thanhTien, forKeyPath: "thanhTien")
            
            do {
                try context.save()
            } catch {
                fatalError("Lưu thất bại: \(error)")
            }
        } else {
            // Warning not empty
            let alert = UIAlertController(title: "Warning", message: "Không được để trống", preferredStyle: UIAlertControllerStyle.alert);
            alert.addAction(UIAlertAction(title: "Biết rồi!!", style: UIAlertActionStyle.default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    //Get date time
    func getDateTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        //dateFormatter.timeZone = NSTimeZone() as TimeZone!
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    //input only numberic
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    // dimiss keyboard when tapping
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

