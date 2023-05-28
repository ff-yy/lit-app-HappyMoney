//
//  InputViewController.swift
//  HappyMoney
//
//  Created by MAC on 2023/05/25.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {
    
    let realm = try! Realm()
    var type: Int = 0
    
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var noteTextField: UITextField!
    @IBOutlet var button: UIButton!
    
    @IBAction func formValueChanged() {
        print("run")
        if (amountTextField.text != "" && noteTextField.text != "") {
            button.isEnabled = true
        }
    }
    
    var elementArray: [Element] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = " "
        amountTextField.keyboardType = UIKeyboardType.numberPad
        button.isEnabled = false
        amountTextField.addTarget(self, action: #selector(InputViewController.textFieldDidChange(_:)), for: .editingChanged)
        noteTextField.addTarget(self, action: #selector(InputViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("run")
        if (amountTextField.text != "" && noteTextField.text != "") {
            button.isEnabled = true
        }

    }

    
    func createElement(element: Element) {
        try! realm.write {
            realm.add(element)
        }
    }
    
    @IBAction func saveElement() {
        let calendar = Calendar(identifier: .gregorian)
        let date = Date()
        let year = ( calendar.component(.year, from: date) - 2000 ) * 10000
        let month = calendar.component(.month, from: date) * 100
//        let day = calendar.component(.day, from: date)
//        let time = year + month + day //ex: 230528
        let time = year + month //ex: 230528
        print(time)
        
        let element = Element()
        element.date = time
//        element.index =
        element.amount = Int(amountTextField.text ?? "") ?? 0
        element.note = noteTextField.text ?? ""
        element.type = type
        createElement(element: element)
    }
    
    // セグメントコントロールのボタンが切り替わった時に呼ばれる
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        type = sender.selectedSegmentIndex
    }

        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
