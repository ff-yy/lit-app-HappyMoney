//
//  AnimationViewController.swift
//  HappyMoney
//
//  Created by MAC on 2023/05/30.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    
    var mainAnimationView = LottieAnimationView()
    var subAnimationView = LottieAnimationView()

    @IBOutlet var emojiLabel: UILabel!
    var element: Element!
    var timer: Timer?
    var elapsedTime: TimeInterval = 0.0
    let happyStringArray: [String] = ["🎉","🥳","😊","🤩","🤑"]
    let happyBGAnimationArray: [String] = ["anime-happybg-confetticannons","anime-happybg-celebration"]
    let moneyMainAnimationArray: [String] = ["anime-moneymain-clapping","anime-moneymain-rupeecoin"]
    let moneyBGAnimationArray: [String] = ["anime-moneybg-rain"]

    func setEmojiLabel() {
        if (element.type == 0) {
            emojiLabel.text = happyStringArray[Int.random(in: 0..<happyStringArray.count)]
        }
        else {
            emojiLabel.text = ""
        }
    }


    
    func startLoop() {
        self.view.addSubview(emojiLabel)
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(loopAction), userInfo: nil, repeats: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.stopLoop()
        }
    }

    @objc func loopAction() {
        // 3秒ごとのループ処理 拡大縮小のアニメーション
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
            self.emojiLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (finished) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                self.emojiLabel.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        
        elapsedTime += 3.0
        if elapsedTime >= 10.0 { // 10秒後には終了
            stopLoop()
        }
    }

    func stopLoop() {
        timer?.invalidate()
        timer = nil
    }


    override func viewDidLoad() {
        
        super.viewDidLoad()
        // 戻るボタンを非表示にする
        self.navigationItem.hidesBackButton = true
        
        // 絵文字用のラベルの設定
        setEmojiLabel()
        
        //アニメーションの呼び出し
        addAnimationView()
        
        
        startLoop()

        

    }
    
   
    //アニメーションの準備
    func addAnimationView() {
        //アニメーションファイルの指定
        if (element.type == 0) { // 出費
            mainAnimationView = LottieAnimationView(name: "") // なし
            subAnimationView = LottieAnimationView(name: happyBGAnimationArray[Int.random(in: 0..<happyBGAnimationArray.count)])
        }
        else { //　収入
            mainAnimationView = LottieAnimationView(name: moneyMainAnimationArray[Int.random(in: 0..<moneyMainAnimationArray.count)])
            subAnimationView = LottieAnimationView(name: moneyBGAnimationArray[Int.random(in: 0..<moneyBGAnimationArray.count)])
            
        }
        
        //アニメーションの位置指定（画面中央）
        mainAnimationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        subAnimationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)

        //アニメーションのアスペクト比を指定＆ループで開始
        mainAnimationView.contentMode = .scaleAspectFit
        mainAnimationView.loopMode = .loop
        mainAnimationView.play()
        subAnimationView.contentMode = .scaleAspectFit
        subAnimationView.loopMode = .loop
        subAnimationView.play()


        //ViewControllerに配置
        view.addSubview(mainAnimationView)
        view.sendSubviewToBack(mainAnimationView)
        view.addSubview(subAnimationView)
        view.sendSubviewToBack(subAnimationView)


    }

    
    @IBAction func backToInputView() {
        //viewcontrollerを破棄する
        dismiss(animated: true)
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
