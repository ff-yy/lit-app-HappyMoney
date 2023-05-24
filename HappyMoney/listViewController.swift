//
//  listViewController.swift
//  HappyMoney
//
//  Created by MAC on 2023/05/24.
//

import UIKit

class listViewController: ViewController {
    
    @IBOutlet var tableView: UITableView!
    //structの定義
    struct Element {
        var date:Int;//日付[yymmdd]
        var index:Int;//同じ日付内での順番
        var amount:Int;//金額
        var note:String;//メモ
    }
     
    //インスタンスを作成して初期値を指定する
    let element = Element(date: 230524, index: 0, amount: 500, note: "テストメモ")
    
    var dataArray: [Dictionary<Int,String>] = []
    let saveData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if saveData.array(forKey: "WORD") != nil {
            dataArray = saveData.array(forKey: "WORD") as! [Dictionary<Int, String>]
        }
        tableView.reloadData()
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
