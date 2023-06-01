//
//  AnimationViewController.swift
//  HappyMoney
//
//  Created by MAC on 2023/05/30.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    
    var animationView = LottieAnimationView()
    @IBOutlet var emojiLabel: UILabel!
    var element: Element!
    var type: Int!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // 戻るボタンを非表示にする
        self.navigationItem.hidesBackButton = true
        
        //アニメーションの呼び出し
        addAnimationView()

        // Do any additional setup after loading the view.
    }
    
    //アニメーションの準備
    func addAnimationView() {
        //アニメーションファイルの指定
        if (type == 0) {
            animationView = LottieAnimationView(name: "7893-confetti-cannons")
        }
        else {
            animationView = LottieAnimationView(name: "145352-kadokado-clapping")
        }
        
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
