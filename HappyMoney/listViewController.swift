//
//  listViewController.swift
//  HappyMoney
//
//  Created by MAC on 2023/05/24.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm()
    @IBOutlet var tableView: UITableView!
    var elementArray: [Element] = []


    // TableViewに表示するセルの数を返却します。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementArray.count
    }
    
    // 各セルを生成して返却します。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを作成します。 デフォルトのスタイルを選択しています。 (Swift2.3までは .Default と大文字で記述します)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! TableViewCell
        
        let element = elementArray[indexPath.row]
//
//        cell.amountLabel.text = String(nowIndexPathDictionary.amount)
//        cell.noteLabel.text = nowIndexPathDictionary.note
        cell.setCell(amount: element.amount, note: element.note, type: element.type)

        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        elementArray = readElementArray()
    }
    
    func readElementArray() -> [Element] {
        return Array(realm.objects(Element.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        elementArray = readElementArray()
        tableView.reloadData()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            switch editingStyle {
            case .delete:
                elementArray.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
            case .insert, .none:
                // NOP
                break
            }
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
