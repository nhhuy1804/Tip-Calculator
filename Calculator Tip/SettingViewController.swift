//
//  SettingViewController.swift
//  Calculator Tip
//
//  Created by MrDummy on 5/30/17.
//  Copyright © 2017 Nhom5. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var txtTipAmount: UITextField!
    
    var tip: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tip = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn5(_ sender: Any) {
        txtTipAmount.text = "5%"
        tip = 5
    }
    
    @IBAction func btn10(_ sender: Any) {
        txtTipAmount.text = "10%"
        tip = 10
    }
    
    @IBAction func btn15(_ sender: Any) {
        txtTipAmount.text = "15%"
        tip = 15
    }
    
    @IBAction func btnSave(_ sender: Any) {
        UserDefaults.standard.set(tip, forKey: "tip")
        self.navigationController?.popViewController(animated: true)
    }
}
