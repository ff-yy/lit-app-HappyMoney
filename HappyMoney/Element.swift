//
//  Element.swift
//  HappyMoney
//
//  Created by MAC on 2023/05/28.
//
import UIKit
import Foundation
import RealmSwift

//クラスの定義
class Element: Object {
    @Persisted var date: Int = 20230528
    @Persisted var index: Int = 0
    @Persisted var amount: Int = 0
    @Persisted var note: String = ""
    @Persisted var type: Int = 0//0支出, 1収入
    //        var date: Int//日付[yymmdd]
    //        var index: Int//同じ日付内での順番
    //    var amount: Int!//金額
    //    var note: String!//メモ
}


