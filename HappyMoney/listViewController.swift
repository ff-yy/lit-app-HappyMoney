//
//  listViewController.swift
//  HappyMoney
//
//  Created by MAC on 2023/05/24.
//

import UIKit
import RealmSwift
import Lottie

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var animationView = LottieAnimationView()
    
    let realm = try! Realm()
    @IBOutlet var tableView: UITableView!
    var allElementArray: [Element] = []
    var monthElementArray: [Element] = []
    var selectedYearMonth: Int = 0 //ex:2305 → 23年の5月
    @IBOutlet var selectedYearMonthLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    var selectedElement: Element = Element()
    
    //AnimationViewControllerから帰ってくる用
    @IBAction func backHere(sender: UIStoryboardSegue) {
    }
            
    
    @IBAction func backButton() {
        selectedYearMonth -= 1
        if (selectedYearMonth % 100 == 0) {//1月から0月になったとき = 下2桁が0
            selectedYearMonth = selectedYearMonth - 100 + 12 //1年前に戻して、12月にする
        }
        reloadViews()
    }
    
    @IBAction func forwardButton() {
        selectedYearMonth += 1
        if (selectedYearMonth % 100 == 13) {//12月から13月になったとき = 下2桁が13
            selectedYearMonth = selectedYearMonth + 100 - 12 //1年先にして、1月にする
        }
        reloadViews()
    }
    
    /**
     ビューの更新をする
     全要素から指定された要素のみフィルターし
     テーブルビューを更新
     ラベルも更新
     */
    func reloadViews() {
        monthElementArray = allElementArray.filter{$0.date/100 == selectedYearMonth}
        tableView.reloadData()
        selectedYearMonthLabel.text = String(2000 + selectedYearMonth/100) + "年 " + String(selectedYearMonth % 100) + "月分"
        updateTotalLabel()

    }
    
    func updateTotalLabel() {
        var sum: Int = 0
        for element in monthElementArray {
            sum += ((element.type == 0) ? -1:1)*element.amount
        }
        totalLabel.text = String(sum)
        if (sum == 0) {
            totalLabel.textColor = UIColor.black
        }
        else if (sum > 0) {
            totalLabel.textColor = UIColor.systemGreen
        }
        else if (sum < 0) {
            totalLabel.textColor = UIColor.systemRed
        }
        
    }
    
    

    // TableViewに表示するセルの数を返却します。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthElementArray.count
    }
    
    // 各セルを生成して返却します。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを作成します。 デフォルトのスタイルを選択しています。 (Swift2.3までは .Default と大文字で記述します)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! TableViewCell
        
        let element = monthElementArray[indexPath.row]

//        cell.amountLabel.text = String(nowIndexPathDictionary.amount)
//        cell.noteLabel.text = nowIndexPathDictionary.note
        cell.setCell(amount: element.amount, note: element.note, type: element.type)

        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //アニメーションの呼び出し
        addAnimationView()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //最初に年と月決定
        let calendar = Calendar(identifier: .gregorian)
        let date = Date()
        let year = ( calendar.component(.year, from: date) - 2000 ) * 100
        let month = calendar.component(.month, from: date)
        let yearMonth = year + month //ex: 2305
        selectedYearMonth = yearMonth
        
    }
    
    //アニメーションの準備
    func addAnimationView() {
        //アニメーションファイルの指定
        animationView = LottieAnimationView(name: "anime-bg-starry")
        
        //アニメーションの位置指定（画面中央）
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)

        //アニメーションのアスペクト比を指定＆ループで開始
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        //ViewControllerに配置
        view.addSubview(animationView)
        view.sendSubviewToBack(animationView)

    }
    
    /**
     Realmからデータを取得する [Element]で返ってくる
     */
    func readElementArray() -> [Element] {
        return Array(realm.objects(Element.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Realmから要素を取得
        allElementArray = readElementArray()
        
        reloadViews()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            switch editingStyle {
            case .delete:
                try! realm.write {
                    let element = monthElementArray[indexPath.row]
                    realm.delete(element)
                }
                monthElementArray.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                updateTotalLabel()
                //allElementArrayも更新（Realmから要素を取得）
                allElementArray = readElementArray()


                
            case .insert, .none:
                // NOP
                break
            @unknown default:
                fatalError()
            }
    }
    
    /**
     値渡し用メソッド
     値渡したい時はprepareメソッドいる
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            let nextView = segue.destination as! EditElementViewController

            nextView.elementSelected = selectedElement
        }
    }
    
    //　セル選択時に呼び出し
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedElement = monthElementArray[indexPath.row]
        performSegue(withIdentifier: "toEdit", sender: self ) //prepare呼び出し
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
