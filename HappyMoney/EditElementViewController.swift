//
//  InputViewController.swift
//  HappyMoney
//
//  Created by MAC on 2023/06/12.
//

import UIKit
import RealmSwift

class EditElementViewController: UIViewController {
    
    let realm = try! Realm()
    var type: Int = 0//0は支出, 1は収入
    var elementSelected: Element!
    
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var noteTextField: UITextField!
    @IBOutlet var button: UIButton!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var datePicker: UIDatePicker!
        
    // 余白タップ時にテキスト入力モード解除
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
   
    // テキストフィールドの閉じるボタン押下時にキーボードを閉じる
    @objc  func closeButtonTapped() {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキストフィールドの閉じるボタン実装
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // スペーサー構築
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン構築
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action:#selector(closeButtonTapped))
        toolBar.items = [spacer, closeButton]
        amountTextField.inputAccessoryView = toolBar
        noteTextField.inputAccessoryView = toolBar
        // テキストフィールドの閉じるボタン実装 終わり

        // 値をそれぞれ代入する
        amountTextField.text = String(elementSelected.amount)
        noteTextField.text = String(elementSelected.note)
        segment.selectedSegmentIndex = elementSelected.type
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        datePicker.date = dateFormatter.date(from: String(elementSelected.date))!
        
        //amountTextFieldのキーボードを数字専用にする
        amountTextField.keyboardType = UIKeyboardType.numberPad
        //ボタンを押せなくする
//        button.isEnabled = false
        textFieldDidChange(amountTextField)
        //イベント登録
        amountTextField.addTarget(self, action: #selector(InputViewController.textFieldDidChange(_:)), for: .editingChanged)
        noteTextField.addTarget(self, action: #selector(InputViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    /**
     テキストフィールドが更新されたときに毎度呼び出される
     ボタンを押せるように更新する
     */
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (amountTextField.text != "" && noteTextField.text != "") {
            button.isEnabled = true
            button.backgroundColor = UIColor.darkGray
            button.layer.cornerRadius = 10
        }
        else {
            button.isEnabled = false
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = 10
        }
    }

  
    
    /**
     ボタン押下時に呼び出される
     Elementクラスを作成して、要素を保存する
     */
    @IBAction func saveElement() {
        let targetElement = realm.objects(Element.self).filter("createdDate == %@", elementSelected.createdDate).first
        
        let elementUpdated = Element()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        elementUpdated.date = Int(dateFormatter.string(from: datePicker.date)) ?? 0
        elementUpdated.amount = Int(amountTextField.text ?? "") ?? 0
        elementUpdated.note = noteTextField.text ?? ""
        elementUpdated.type = type
        
        do {
          try realm.write {
              targetElement?.date = elementUpdated.date
              targetElement?.amount = elementUpdated.amount
              targetElement?.note = elementUpdated.note
              targetElement?.type = elementUpdated.type
          }
        }
        catch {
          print("Error \(error)")
        }
                
        navigationController?.popViewController(animated: true)
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
