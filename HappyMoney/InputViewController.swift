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
    var type: Int = 0//0は支出, 1は収入
    var element: Element!
    
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var noteTextField: UITextField!
    @IBOutlet var button: UIButton!
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
     Realmに要素を追加する
     */
    func createElement(element: Element) {
        try! realm.write {
            realm.add(element)
        }
    }
    
    
    
    /**
     ボタン押下時に呼び出される
     Elementクラスを作成して、要素を保存する
     */
    @IBAction func saveElement() {
        let element = Element()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        element.date = Int(dateFormatter.string(from: datePicker.date)) ?? 0
        element.amount = Int(amountTextField.text ?? "") ?? 0
        element.note = noteTextField.text ?? ""
        element.type = type
        createElement(element: element)
        self.element = element
        
        amountTextField.text = ""
        noteTextField.text = ""
        button.isEnabled = false
        
        performSegue(withIdentifier: "toAnimation", sender: self ) //prepare呼び出し
    }
    
    /**
     値渡し用メソッド
     値渡したい時はprepareメソッドいる
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnimation" {
            let nextView = segue.destination as! AnimationViewController

            nextView.element = element
        }
    }
    
    // セグメントコントロールのボタンが切り替わった時に呼ばれる
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        type = sender.selectedSegmentIndex
//        print(type)
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
